//
//  JobListUnitTests.swift
//  Job HubTests
//
//  Created by Luis Ligunas on 12/30/20.
//

import XCTest
@testable import Job_Hub

class JobListUnitTests: XCTestCase {
	
	private let jobs: [Job] = {
		return (0..<20).map { i in
			.init(id: "\(i)",
				  jobType: .contract,
				  url: "https://www.google.com",
				  createdAt: .init(),
				  company: "Test company \(i)",
				  companyURL: nil,
				  location: "Test location \(i)",
				  title: "Test title \(i)",
				  description: "Test description \(i)",
				  howToApply: "Test how to apply \(i)",
				  companyLogo: "https://picsum.photos/\(200 + i)")
		}
	}()
	
	func testLoadingFirstJobListPageShouldBeCorrect() {
		let jobListViewModel = JobListViewModel(jobListProvider: MockJobListProvider(jobs: jobs))
		let jobArray = Array(jobs[0...4])
		
		(0...4).forEach { _ in
			jobListViewModel.loadFirstPage { result in
				switch result {
				case .success(let jobs):
					XCTAssertEqual(jobs, jobArray)
				case .failure:
					XCTFail()
				}
			}
		}
		XCTAssertEqual(jobListViewModel.jobs, jobArray)
	}
	
	func testLoadingNextJobListPageShouldBeCorrect() {
		let jobListViewModel = JobListViewModel(jobListProvider: MockJobListProvider(jobs: jobs))
		
		(0...3).forEach { i in
			let leftIndex = i * 5
			let rightIndex = leftIndex + 4
			let jobArray = Array(jobs[leftIndex...rightIndex])
			
			jobListViewModel.loadNextPage { result in
				guard case .success(let jobs) = result else {
					XCTFail()
					return
				}
				XCTAssertEqual(jobs, jobArray)
			}
		}
		
		(0...1).forEach { _ in
			jobListViewModel.loadNextPage { result in
				guard case .success(let jobs) = result else {
					XCTFail()
					return
				}
				XCTAssertEqual(jobs, [])
			}
		}
		XCTAssertEqual(jobListViewModel.jobs, jobs)
	}
	
	func testGettingCompanyImageShouldBeCorrect() {
		let range = (0...2)
		let testImages = range.map { _ in UIImage() }
		
		var jobToImage = [String : UIImage]()
		range.forEach { i in
			let jobID = jobs[i].id
			jobToImage[jobID] = testImages[i]
		}
		
		let companyImageProvider = MockCompanyImageProvider(jobToImage: jobToImage)
		let jobListViewModel = JobListViewModel(companyImageProvider: companyImageProvider)
		
		range.forEach { i in
			jobListViewModel.getCompanyImage(job: jobs[i]) { result in
				guard case .success(let image) = result else {
					XCTFail()
					return
				}
				XCTAssertEqual(image, testImages[i])
			}
		}
	}
	
	func testCachingCompanyImageShouldBeCorrect() {
		let range = (0...2)
		let testImages = range.map { _ in UIImage() }
		
		var jobToImage = [String : UIImage]()
		range.forEach { i in
			let jobID = jobs[i].id
			jobToImage[jobID] = testImages[i]
		}
		
		let companyImageProvider = MockCompanyImageProvider(jobToImage: jobToImage)
		let jobListViewModel = JobListViewModel(companyImageProvider: companyImageProvider)
		
		range.forEach { i in
			jobListViewModel.cacheCompanyImage(job: jobs[i]) { result in
				guard case .success(let image) = result else {
					XCTFail()
					return
				}
				XCTAssertEqual(image, testImages[i])
			}
		}
	}
}

private struct MockJobListProvider: JobListProvider {
	let jobs: [Job]
	
	func getJobList(page: Int, completion: @escaping (Result<[Job], Error>) -> Void) {
		guard page <= 4 else {
			completion(.success([]))
			return
		}
		let leftIndex = (page - 1) * 5
		let rightIndex = leftIndex + 4
		let jobArray = Array(jobs[leftIndex...rightIndex])
		completion(.success(jobArray))
	}
}

private struct MockCompanyImageProvider: CompanyImageProvider {
	let jobToImage: [String : UIImage]
	
	func getCompanyImage(job: Job, completion: @escaping (Result<UIImage, Error>) -> Void) {
		guard let image = jobToImage[job.id] else {
			completion(.failure(JHError.general))
			return
		}
		completion(.success(image))
	}
	
	func cacheCompanyImage(job: Job, completion: @escaping (Result<UIImage, Error>) -> Void) {
		guard let image = jobToImage[job.id] else {
			completion(.failure(JHError.general))
			return
		}
		completion(.success(image))
	}
}

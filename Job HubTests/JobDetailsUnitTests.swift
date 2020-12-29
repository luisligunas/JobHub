//
//  JobDetailsUnitTests.swift
//  Job HubTests
//
//  Created by Luis Ligunas on 12/30/20.
//

import XCTest
@testable import Job_Hub

class JobDetailsUnitTests: XCTestCase {
	
	private let job = Job(id: "1",
						  jobType: .contract,
						  url: "https://www.google.com",
						  createdAt: .init(),
						  company: "Test company 1",
						  companyURL: nil,
						  location: "Test location 1",
						  title: "Test title 1",
						  description: "Test description 1",
						  howToApply: "Test how to apply 1",
						  companyLogo: "https://picsum.photos/200")
	
	func testGettingJobDetail() {
		let jobDetailsProvider = MockJobDetailsProvider(job: job, companyImage: UIImage())
		let jobDetailsViewModel = JobDetailsViewModel(jobDetailsProvider: jobDetailsProvider)
		
		jobDetailsViewModel.getJobDetails { [weak self] result in
			guard let originalJob = self?.job,
				  case .success(let job) = result else {
				XCTFail()
				return
			}
			XCTAssertEqual(originalJob, job)
		}
	}
	
	func testGettingCompanyImage() {
		let testCompanyImage = UIImage()
		let jobDetailsProvider = MockJobDetailsProvider(job: job, companyImage: testCompanyImage)
		let jobDetailsViewModel = JobDetailsViewModel(jobDetailsProvider: jobDetailsProvider)
		
		let semaphore = DispatchSemaphore(value: 0)
		jobDetailsViewModel.getJobDetails { result in
			semaphore.signal()
		}
		semaphore.wait()
		
		jobDetailsViewModel.getCompanyImage { result in
			guard case .success(let image) = result else {
				XCTFail()
				return
			}
			XCTAssertEqual(image, testCompanyImage)
			semaphore.signal()
		}
		semaphore.wait()
		
		XCTAssertEqual(jobDetailsViewModel.companyImage, testCompanyImage)
		XCTAssertEqual(jobDetailsViewModel.job, job)
	}
}

private struct MockJobDetailsProvider: JobDetailsProvider {
	let job: Job
	let companyImage: UIImage
	
	func getJobDetails(completion: @escaping (Result<Job, Error>) -> Void) {
		completion(.success(job))
	}
	
	func getCompanyImage(job: Job, completion: @escaping (Result<UIImage, Error>) -> Void) {
		guard job == self.job else {
			completion(.success(UIImage()))
			return
		}
		completion(.success(companyImage))
	}
}

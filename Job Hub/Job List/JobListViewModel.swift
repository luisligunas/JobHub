//
//  JobListViewModel.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation
import UIKit

class JobListViewModel {
	
	private let jobListProvider: JobListProvider
	private let cachedJobListProvider: CachedJobListProvider?
	private let companyImageProvider: CompanyImageProvider
	
	private(set) var jobs = [Job]()
	private var jobListPage: Int = 1
	
	init(jobListProvider: JobListProvider = GitHubJobListService(),
		 companyImageProvider: CompanyImageProvider = KingFisherImageService(),
		 cachedJobListProvider: CachedJobListProvider? = CoreDataCachedJobListService()) {
		self.jobListProvider = jobListProvider
		self.companyImageProvider = companyImageProvider
		self.cachedJobListProvider = cachedJobListProvider
	}
	
	func loadFirstPage(completion: @escaping (Result<[Job], Error>) -> Void) {
		loadPage(page: 1, completion: completion)
	}
	
	func loadNextPage(completion: @escaping (Result<[Job], Error>) -> Void) {
		loadPage(page: jobListPage, completion: completion)
	}
	
	private func loadPage(page: Int, completion: @escaping (Result<[Job], Error>) -> Void) {
		jobListProvider.getJobList(page: page) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let jobs):
				if !jobs.isEmpty {
					self.jobListPage = max(page + 1, self.jobListPage)
				}
				self.addJobs(jobs)
				self.cachedJobListProvider?.saveJobListToCache(jobs: jobs, completion: nil)
				completion(.success(jobs))
			case .failure(let error):
				guard let cachedJobListProvider = self.cachedJobListProvider else {
					completion(.failure(error))
					return
				}
				cachedJobListProvider.getCachedJobList { [weak self] result in
					guard let self = self else { return }
					
					switch result {
					case .success(let jobs):
						self.addJobs(jobs)
						completion(.success(jobs))
					case .failure(let error):
						completion(.failure(error))
					}
				}
			}
		}
	}
	
	func getCompanyImage(job: Job, completion: @escaping (Result<UIImage, Error>) -> Void) {
		companyImageProvider.getCompanyImage(job: job, completion: completion)
	}
	
	func cacheCompanyImage(job: Job, completion: @escaping (Result<UIImage, Error>) -> Void) {
		companyImageProvider.cacheCompanyImage(job: job, completion: completion)
	}
	
	private func addJobs(_ jobs: [Job]) {
		self.jobs += jobs.compactMap { job -> Job? in
			guard !self.jobs.contains(where: { $0.id == job.id }) else { return nil }
			return job
		}
	}
}

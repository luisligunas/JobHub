//
//  JobListViewModel.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation

class JobListViewModel {
	
	private let jobListProvider: JobListProvider
	private(set) var jobs = [Job]()
	private var jobListPage: Int = 1
	
	init(jobListProvider: JobListProvider = GitHubJobListService()) {
		self.jobListProvider = jobListProvider
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
				completion(.success(jobs))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	private func addJobs(_ jobs: [Job]) {
		self.jobs += jobs.compactMap { job -> Job? in
			guard !self.jobs.contains(where: { $0.id == job.id }) else { return nil }
			return job
		}
		self.jobs.sort { first, second -> Bool in
			guard let firstDate = Date.date(from: first.createdAt, withDateFormat: .expandedUTC),
				  let secondDate = Date.date(from: second.createdAt, withDateFormat: .expandedUTC)
			else { return false }
			return firstDate > secondDate
		}
	}
}

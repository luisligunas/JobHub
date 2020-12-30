//
//  CoreDataCachedJobListService.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/30/20.
//

import Foundation

struct CoreDataCachedJobListService: CachedJobListProvider {
	func getCachedJobList(completion: @escaping (Result<[Job], Error>) -> Void) {
		let jobs = CoreDataService.shared.fetchJobs()
		completion(.success(jobs))
	}
	
	func saveJobListToCache(jobs: [Job], completion: (() -> Void)? = nil) {
		CoreDataService.shared.saveJobs(jobs)
		completion?()
	}
}

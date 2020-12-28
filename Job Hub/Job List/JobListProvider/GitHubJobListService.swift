//
//  GitHubJobListService.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation

struct GitHubJobListService: JobListProvider {
	
	func getJobList(page: Int, completion: @escaping (Result<[Job], Error>) -> Void) {
		API.shared.gitHubJobsRequest(target: .getJobList(options: .init(page: page - 1))) { result in
			switch result {
			case .success(let response):
				guard let response = try? response.map(GetJobListResponse.self) else {
					completion(.failure(JHError.general))
					return
				}
				let jobs = response.map { $0.asJob }
				completion(.success(jobs))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}

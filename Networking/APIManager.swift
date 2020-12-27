//
//  APIManager.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation
import Moya

class API: NSObject {
	static let shared = API()
	
	private override init() {}
	
	private lazy var githubJobsProvider = MoyaProvider<GitHubJobsAPI>(plugins: [NetworkLoggerPlugin(configuration: configuration)])
	
	private let configuration: NetworkLoggerPlugin.Configuration = {
		var configuration = NetworkLoggerPlugin.Configuration()
		configuration.logOptions = .formatRequestAscURL
		return configuration
	}()
	
	typealias RequestCompletionBlock = (Result<Response, Error>) -> Void
	
	func gitHubJobsRequest(target: GitHubJobsAPI, onCompletion: @escaping RequestCompletionBlock) {
		self.commonRequest(target: target, provider: githubJobsProvider, onCompletion: onCompletion)
	}
	
	private func commonRequest<T: TargetType>(target: T,
											  provider: MoyaProvider<T>,
											  onCompletion: @escaping RequestCompletionBlock) {
		provider.request(target) { result in
			switch result {
			case .success(let response):
				let responseIsSuccessful = response.statusCode >= 200 && response.statusCode <= 299
				let responseString = (try? response.mapString()) ?? "Error showing response"
				
				if responseIsSuccessful {
					print("✅ SUCCESS - \(responseString)")
				} else {
					print("❌ FAILURE - \(responseString)")
				}
				
				onCompletion(.success(response))
			case .failure(let error):
				let errorMessage = error.localizedDescription
				print("❌ FAILURE - \(errorMessage)")
				
				onCompletion(.failure(error))
			}
		}
	}
}

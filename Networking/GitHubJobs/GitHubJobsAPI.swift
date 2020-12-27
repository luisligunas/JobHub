//
//  GitHubJobsAPI.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation
import Moya

enum GitHubJobsAPI {
	case getJobList(options: GetJobListOptions)
}

extension GitHubJobsAPI: TargetType {
	var baseURL: URL {
		return URL(string: "https://jobs.github.com")!
	}
	
	var path: String {
		switch self {
		case .getJobList:
			return "/positions.json"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .getJobList:
			return .get
		}
	}
	
	var task: Task {
		var urlParameters = [String: Any]()
		
		switch self {
		case .getJobList(let options as RequestParameter):
			urlParameters = options.urlParameters
		}
		
		switch self {
		case .getJobList:
			return .requestParameters(parameters: urlParameters,
									  encoding: URLEncoding.default)
		}
	}
	
	var headers: [String : String]? {
		switch self {
		case .getJobList:
			return nil
		}
	}
	
	var sampleData: Data {
		return Data()
	}
}

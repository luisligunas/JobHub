//
//  GetJobListResponse.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation

struct GetJobListResponseItem: Codable {
	let id: String
	let type: GetJobListResponseItemJobType
	let url: String
	let createdAt, company: String
	let companyURL: String?
	let location, title, description, howToApply: String
	let companyLogo: String?
	
	enum CodingKeys: String, CodingKey {
		case id, type, url
		case createdAt = "created_at"
		case company
		case companyURL = "company_url"
		case location, title
		case description
		case howToApply = "how_to_apply"
		case companyLogo = "company_logo"
	}
}

enum GetJobListResponseItemJobType: String, Codable {
	case contract = "Contract"
	case fullTime = "Full Time"
	case partTime = "Part Time"
}

typealias GetJobListResponse = [GetJobListResponseItem]

extension GetJobListResponseItem {
	var asJob: Job {
		return .init(id: id,
					 jobType: type.asJobType,
					 url: url,
					 createdAt: Date.date(from: createdAt, withDateFormat: .expandedUTC) ?? .init(),
					 company: company,
					 companyURL: companyURL,
					 location: location,
					 title: title,
					 description: description,
					 howToApply: howToApply,
					 companyLogo: companyLogo)
	}
}

extension GetJobListResponseItemJobType {
	var asJobType: JobType {
		switch self {
		case .contract: return .contract
		case .fullTime: return .fullTime
		case .partTime: return .partTime
		}
	}
}

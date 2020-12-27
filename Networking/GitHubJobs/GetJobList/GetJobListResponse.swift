//
//  GetJobListResponse.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation

struct GetJobListResponseItem: Codable {
	let id: String
	let type: JobType
	let url: String
	let createdAt, company: String
	let companyURL: String?
	let location, title, bruhDescription, howToApply: String
	let companyLogo: String?
	
	enum CodingKeys: String, CodingKey {
		case id, type, url
		case createdAt = "created_at"
		case company
		case companyURL = "company_url"
		case location, title
		case bruhDescription = "description"
		case howToApply = "how_to_apply"
		case companyLogo = "company_logo"
	}
}

enum JobType: String, Codable {
	case contract = "Contract"
	case fullTime = "Full Time"
	case partTime = "Part Time"
}

typealias GetJobListResponse = [GetJobListResponseItem]

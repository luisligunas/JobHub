//
//  Job.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation

struct Job {
	let id: String
	let jobType: JobType
	let url: String
	let createdAt: Date
	let company: String
	let companyURL: String?
	let location, title, description, howToApply: String
	let companyLogo: String?
}

enum JobType: String {
	case contract = "contract"
	case fullTime = "fullTime"
	case partTime = "partTime"
}

extension Job: Equatable {
	static func ==(lhs: Job, rhs: Job) -> Bool {
		return lhs.id == rhs.id
	}
}

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

enum JobType {
	case contract
	case fullTime
	case partTime
}

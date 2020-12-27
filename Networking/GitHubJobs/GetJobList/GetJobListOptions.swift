//
//  GetJobListOptions.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation

struct GetJobListOptions {
	private let page: Int
	
	init(page: Int = 0) {
		self.page = page
	}
}

extension GetJobListOptions: RequestParameter {
	var urlParameters: [String : Any] {
		var urlParameters = [String : Any]()
		urlParameters["page"] = page
		return urlParameters
	}
}

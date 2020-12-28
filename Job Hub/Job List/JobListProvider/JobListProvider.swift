//
//  JobListProvider.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation

protocol JobListProvider {
	func getJobList(page: Int, completion: @escaping (Result<[Job], Error>) -> Void)
}

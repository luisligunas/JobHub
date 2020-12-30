//
//  CachedJobListProvider.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/30/20.
//

import Foundation

protocol CachedJobListProvider {
	func getCachedJobList(completion: @escaping (Result<[Job], Error>) -> Void)
	func saveJobListToCache(jobs: [Job], completion: (() -> Void)?)
}

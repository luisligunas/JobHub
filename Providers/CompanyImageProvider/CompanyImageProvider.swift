//
//  CompanyImageProvider.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/30/20.
//

import Foundation
import UIKit

protocol CompanyImageProvider {
	func getCompanyImage(job: Job, completion: @escaping (Result<UIImage, Error>) -> Void)
	func cacheCompanyImage(job: Job, completion: @escaping (Result<UIImage, Error>) -> Void)
}

extension CompanyImageProvider {
	func cacheCompanyImage(job: Job, completion: @escaping (Result<UIImage, Error>) -> Void) {
		completion(.failure(JHError.general))
	}
}

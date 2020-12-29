//
//  LocalJobDetailsService.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation
import UIKit

struct LocalJobDetailsService: JobDetailsProvider {
	
	private let job: Job
	
	init(job: Job) {
		self.job = job
	}
	
	func getJobDetails(completion: @escaping (Result<Job, Error>) -> Void) {
		completion(.success(job))
	}
	
	func getCompanyImage(completion: @escaping (Result<UIImage, Error>) -> Void) {
		guard let companyURL = job.companyLogo else {
			completion(.failure(JHError.general))
			return
		}
		UIImage.download(from: companyURL) { image in
			guard let image = image else {
				completion(.failure(JHError.general))
				return
			}
			completion(.success(image))
		}
	}
}

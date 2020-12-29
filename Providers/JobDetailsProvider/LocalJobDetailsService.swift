//
//  LocalJobDetailsService.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation
import Kingfisher
import UIKit

struct LocalJobDetailsService: JobDetailsProvider {
	
	private let job: Job
	
	init(job: Job) {
		self.job = job
	}
	
	func getJobDetails(completion: @escaping (Result<Job, Error>) -> Void) {
		completion(.success(job))
	}
	
	func getCompanyImage(job: Job, completion: @escaping (Result<UIImage, Error>) -> Void) {
		guard let companyURLString = job.companyLogo,
			  let companyURL = URL(string: companyURLString) else {
			completion(.failure(JHError.general))
			return
		}
		KingfisherManager.shared.retrieveImage(with: companyURL) { result in
			switch result {
			case .success(let imageResult):
				completion(.success(imageResult.image))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}

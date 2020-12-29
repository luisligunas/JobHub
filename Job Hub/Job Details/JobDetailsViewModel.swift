//
//  JobDetailsViewModel.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation
import UIKit

class JobDetailsViewModel {
	private let jobDetailsProvider: JobDetailsProvider
	
	private(set) var job: Job?
	private(set) var companyImage: UIImage?
	
	init(jobDetailsProvider: JobDetailsProvider) {
		self.jobDetailsProvider = jobDetailsProvider
	}
	
	convenience init(job: Job) {
		self.init(jobDetailsProvider: LocalJobDetailsService(job: job))
	}
	
	func getJobDetails(completion: @escaping (Result<Job, Error>) -> Void) {
		jobDetailsProvider.getJobDetails { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let job):
				self.job = job
				completion(.success(job))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func getCompanyImage(completion: @escaping (Result<UIImage, Error>) -> Void) {
		if let companyImage = companyImage {
			completion(.success(companyImage))
			return
		}
		
		guard let job = job else {
			completion(.failure(JHError.general))
			return
		}
		
		jobDetailsProvider.getCompanyImage(job: job) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let image):
				self.companyImage = image
				completion(.success(image))
			case .failure(let error) :
				completion(.failure(error))
			}
		}
	}
}

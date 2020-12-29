//
//  KingFisherImageService.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/30/20.
//

import Foundation
import Kingfisher
import UIKit

struct KingFisherImageService: CompanyImageProvider {
	func getCompanyImage(job: Job, completion: @escaping (Result<UIImage, Error>) -> Void) {
		guard let companyLogoURLString = job.companyLogo,
			  let companyLogoURL = URL(string: companyLogoURLString)
		else { return }
		
		KingfisherManager.shared.retrieveImage(with: companyLogoURL) { result in
			switch result {
			case .success(let imageResult):
				completion(.success(imageResult.image))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}

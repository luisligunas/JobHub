//
//  JobDetailsProvider.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation
import UIKit

protocol JobDetailsProvider {
	func getJobDetails(completion: @escaping (Result<Job, Error>) -> Void)
	func getCompanyImage(completion: @escaping (Result<UIImage, Error>) -> Void)
}

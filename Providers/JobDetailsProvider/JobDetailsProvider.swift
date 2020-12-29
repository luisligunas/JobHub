//
//  JobDetailsProvider.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation
import UIKit

protocol JobDetailsProvider: CompanyImageProvider {
	func getJobDetails(completion: @escaping (Result<Job, Error>) -> Void)
}

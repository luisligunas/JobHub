//
//  JobListNavigationController.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/29/20.
//

import Foundation
import UIKit

class JobListNavigationController: UINavigationController {
	
	convenience init() {
		self.init(rootViewController: JobListViewController())
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		ThemeService.theme.preferredStatusBarStyle
	}
}

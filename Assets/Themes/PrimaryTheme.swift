//
//  PrimaryTheme.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation
import UIKit

struct PrimaryTheme: Theme {
	var backgroundColor: UIColor { return .primaryColor }
	var textColor: UIColor { return .tertiaryColor }
	var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}

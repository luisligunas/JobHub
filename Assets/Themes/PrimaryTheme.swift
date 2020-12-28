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
	var tintColor: UIColor { return .white }
	var textColor: UIColor { return .tertiaryColor }
	
	var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
	var activityIndicatorViewStyle: UIActivityIndicatorView.Style { return .white }
}

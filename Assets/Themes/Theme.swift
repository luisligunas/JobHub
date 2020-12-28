//
//  Theme.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation
import UIKit

protocol Theme {
	var backgroundColor: UIColor { get }
	var tintColor: UIColor { get }
	var textColor: UIColor { get }
	
	var preferredStatusBarStyle: UIStatusBarStyle { get }
	var activityIndicatorViewStyle: UIActivityIndicatorView.Style { get }
}

extension Theme {
	var backgroundColor: UIColor { return .primaryColor }
	var tintColor: UIColor { return .white }
	var textColor: UIColor { return .tertiaryColor }
	
	var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
	var activityIndicatorViewStyle: UIActivityIndicatorView.Style { return .white }
}

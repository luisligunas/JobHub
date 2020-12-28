//
//  ThemeService.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation
import UIKit

class ThemeService {
	
	private(set) static var theme: Theme = PrimaryTheme()
	
	private init() {}
	
	static func setTheme(_ themeType: ThemeType) {
		let theme = themeType.theme
		ThemeService.theme = theme
		
		UIRefreshControl.appearance().tintColor = theme.tintColor
		UIActivityIndicatorView.appearance().tintColor = theme.tintColor
		UIActivityIndicatorView.appearance().style = theme.activityIndicatorViewStyle
	}
}

enum ThemeType {
	case primary
	
	var theme: Theme {
		switch self {
		case .primary: return PrimaryTheme()
		}
	}
}

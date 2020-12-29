//
//  ThemeService.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation
import UIKit

class ThemeService {
	
	private(set) static var theme: Theme = DefaultTheme()
	
	private init() {}
	
	static func setTheme(_ themeType: ThemeType) {
		let theme = themeType.theme
		ThemeService.theme = theme
		
		UIRefreshControl.appearance().tintColor = theme.tintColor
		UIActivityIndicatorView.appearance().tintColor = theme.tintColor
		UIActivityIndicatorView.appearance().style = theme.activityIndicatorViewStyle
		
		UINavigationBar.appearance().barTintColor = theme.navigationBarTintColor
		UINavigationBar.appearance().titleTextAttributes = theme.navigationBarTitleTextAttributes
		
		UIBarButtonItem.appearance().tintColor = theme.barButtonItemTintColor
	}
}

enum ThemeType {
	case `default`
	
	var theme: Theme {
		switch self {
		case .default: return DefaultTheme()
		}
	}
}

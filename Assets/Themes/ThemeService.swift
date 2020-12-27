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
		ThemeService.theme = themeType.theme
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

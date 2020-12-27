//
//  PrimaryColorTheme.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation
import UIKit

struct PrimaryColorThemeType: ColorThemeType {
	var background: BackgroundColor = PrimaryBackgroundColor()
	var text: TextColor = PrimaryTextColor()
}

struct PrimaryBackgroundColor: BackgroundColor {
	func color(for backgroundColorType: BackgroundColorType) -> UIColor {
		switch backgroundColorType {
		case .main: return .primaryColor
		}
	}
}

struct PrimaryTextColor: TextColor {
	func color(for textColorType: TextColorType) -> UIColor {
		switch textColorType {
		case .main: return .tertiaryColor
		}
	}
}

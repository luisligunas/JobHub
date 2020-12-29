//
//  UILabel+Extensions.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/29/20.
//

import Foundation
import UIKit

public extension UILabel {
	func setTextThemeType(_ textThemeType: TextThemeType) {
		font = ThemeService.theme.textFontTheme.font(for: textThemeType)
		textColor = ThemeService.theme.textColorTheme.color(for: textThemeType)
	}
}

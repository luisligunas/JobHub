//
//  TextColorTheme.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/29/20.
//

import Foundation
import UIKit

protocol TextColorTheme {
	func color(for textThemeType: TextThemeType) -> UIColor
}

extension TextColorTheme {
	func color(for textThemeType: TextThemeType) -> UIColor {
		return .primaryColor
	}
}

struct DefaultTextColorTheme: TextColorTheme {}

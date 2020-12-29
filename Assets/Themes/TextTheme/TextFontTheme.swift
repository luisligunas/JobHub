//
//  TextFontTheme.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/29/20.
//

import Foundation
import UIKit

protocol TextFontTheme {
	func font(for textThemeType: TextThemeType) -> UIFont?
}

extension TextFontTheme {
	func font(for textThemeType: TextThemeType) -> UIFont? {
		switch textThemeType {
		case .title1: return R.font.robotoBold(size: 28)
		case .title2: return R.font.robotoBold(size: 22)
		case .title3: return R.font.robotoBold(size: 20)
		case .headline: return R.font.robotoBold(size: 17)
		case .body: return R.font.robotoRegular(size: 17)
		case .callout: return R.font.robotoRegular(size: 16)
		case .subhead: return R.font.robotoRegular(size: 15)
		case .footnote: return R.font.robotoRegular(size: 13)
		case .caption1: return R.font.robotoLight(size: 12)
		case .caption2: return R.font.robotoLight(size: 11)
		}
	}
}

struct DefaultTextFontTheme: TextFontTheme {}

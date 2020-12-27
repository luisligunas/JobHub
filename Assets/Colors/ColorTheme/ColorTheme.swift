//
//  ColorTheme.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation
import UIKit

public protocol ColorThemeType {
	var background: BackgroundColor { get }
	var text: TextColor { get }
}

public enum ColorTheme {
	case primary
	
	private var type: ColorThemeType {
		switch self {
		case .primary: return PrimaryColorThemeType()
		}
	}
	
	func background(for backgroundColorType: BackgroundColorType) -> UIColor {
		return type.background.color(for: backgroundColorType)
	}
	
	func text(for textColorType: TextColorType) -> UIColor {
		return type.text.color(for: textColorType)
	}
}

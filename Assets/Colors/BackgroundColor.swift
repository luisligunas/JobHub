//
//  BackgroundColor.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation
import UIKit

public protocol BackgroundColor {
	func color(for backgroundColorType: BackgroundColorType) -> UIColor
}

public enum BackgroundColorType {
	// Add a new case for each new type of background
	case main
}

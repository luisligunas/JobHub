//
//  TextColor.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation
import UIKit

public protocol TextColor {
	func color(for textColorType: TextColorType) -> UIColor
}

public enum TextColorType {
	// Add a new case for each new type of text
	case main
}

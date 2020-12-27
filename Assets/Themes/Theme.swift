//
//  Theme.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation
import UIKit

protocol Theme {
	var backgroundColor: UIColor { get }
	var textColor: UIColor { get }
}

extension Theme {
	var backgroundColor: UIColor { return .primaryColor }
	var textColor: UIColor { return .tertiaryColor }
}

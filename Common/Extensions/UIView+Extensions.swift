//
//  UIView+Extensions.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation
import UIKit

public extension UIView {
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}

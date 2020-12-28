//
//  Date+Extensions.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation

public enum DateFormat {
	case expandedUTC // Wed Dec 04 22:43:07 UTC 2020
}

private extension DateFormat {
	var formatString: String {
		switch self {
		case .expandedUTC:
			return "E MMM dd HH:mm:ss 'UTC' yyyy"
		}
	}
}

public extension Date {
	
	static func date(from string: String, withDateFormat dateFormat: DateFormat) -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = dateFormat.formatString
		return dateFormatter.date(from: string)
	}
	
	func toString(withDateFormat dateFormat: DateFormat) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = dateFormat.formatString
		return dateFormatter.string(from: self)
	}
}

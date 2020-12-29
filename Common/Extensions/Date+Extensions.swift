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
	
	var isToday: Bool {
		return Calendar.current.isDateInToday(self.asLocalDate)
	}
	
	var isYesterday: Bool {
		return Calendar.current.isDateInYesterday(self.asLocalDate)
	}
	
	var asLocalDate: Date {
		// Source: https://stackoverflow.com/a/46390754
		let timezone = TimeZone.current
		let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
		return Date(timeInterval: seconds, since: self)
	}
	
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
	
	func difference(from date: Date, of component: Calendar.Component) -> Int {
		return Calendar.current.dateComponents([component], from: date, to: self).value(for: component) ?? 0
	}
	
	var relativeString: String {
		let dayDifference = Date().difference(from: self, of: .day)
		let monthDifference = Date().difference(from: self, of: .month)
		let yearDifference = Date().difference(from: self, of: .year)
		
		if isToday {
			return R.string.localizable.timeToday()
		} else if isYesterday {
			return R.string.localizable.timeYesterday()
		} else if dayDifference < 7 {
			return R.string.localizable.timeXDaysAgo(dayDifference)
		} else if dayDifference < 14 {
			return R.string.localizable.timeLastWeek()
		} else if monthDifference < 1 {
			return R.string.localizable.timeXWeeksAgo(dayDifference / 7)
		} else if monthDifference < 2 {
			return R.string.localizable.timeLastMonth()
		} else if yearDifference < 1 {
			return R.string.localizable.timeXMonthsAgo(monthDifference)
		} else if yearDifference < 2 {
			return R.string.localizable.timeLastYear()
		} else {
			return R.string.localizable.timeXYearsAgo(yearDifference)
		}
	}
}

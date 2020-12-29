//
//  String+Extensions.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/29/20.
//

import Foundation
import UIKit

public extension String {
	func attributed(font: UIFont? = nil,
					textColor: UIColor? = nil,
					textAlignment: NSTextAlignment? = nil,
					underlineStyle: NSUnderlineStyle? = nil) -> NSMutableAttributedString {
		
		let attributedString = NSAttributedString(string: self)
		return attributedString.attributed(font: font,
										   textColor: textColor,
										   textAlignment: textAlignment,
										   underlineStyle: underlineStyle)
	}
}

public extension String {
	// Source: https://stackoverflow.com/a/47230632
	var htmlToAttributedString: NSAttributedString? {
		guard let data = data(using: .utf8) else { return nil }
		return try? NSAttributedString(data: data,
									   options: [.documentType: NSAttributedString.DocumentType.html,
												 .characterEncoding: String.Encoding.utf8.rawValue],
									   documentAttributes: nil)
	}
	
	var htmlToString: String? {
		return htmlToAttributedString?.string
	}
}

//
//  NSAttributedString+Extensions.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/29/20.
//

import Foundation
import UIKit

public extension NSAttributedString {
	func attributed(font: UIFont? = nil,
					textColor: UIColor? = nil,
					textAlignment: NSTextAlignment? = nil,
					underlineStyle: NSUnderlineStyle? = nil) -> NSMutableAttributedString {
		var attributes = [NSAttributedString.Key: Any]()
		
		if let textColor = textColor {
			attributes[.foregroundColor] = textColor
		}
		
		if let font = font {
			attributes[.font] = font
		}
		
		if let textAlignment = textAlignment {
			let paragraphStyle = NSMutableParagraphStyle()
			paragraphStyle.alignment = textAlignment
			attributes[.paragraphStyle] = paragraphStyle
		}
		
		if let underlineStyle = underlineStyle {
			attributes[.underlineStyle] = underlineStyle.rawValue
		}
		
		let mutableAttributedString = NSMutableAttributedString(attributedString: self)
		mutableAttributedString.addAttributes(attributes,
											  range: .init(location: 0, length: mutableAttributedString.length))
		return mutableAttributedString
	}
	
	func withIncreasedFontSize(_ increasedPointSize: CGFloat) -> NSMutableAttributedString {
		let mutableAttributedString = NSMutableAttributedString(attributedString: self)
		let range = NSRange(location: 0, length: mutableAttributedString.length)
		
		mutableAttributedString.enumerateAttribute(.font, in: range) { value, range, _ in
			guard let oldFont = value as? UIFont else { return }
			let oldPointSize = oldFont.pointSize
			let newFont = oldFont.withSize(oldPointSize + increasedPointSize)
			mutableAttributedString.addAttribute(.font, value: newFont, range: range)
		}
		return mutableAttributedString
	}
}

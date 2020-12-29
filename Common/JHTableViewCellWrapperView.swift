//
//  JHTableViewCellWrapperView.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/29/20.
//

import Foundation
import UIKit

class JHTableViewCellWrapperView: UIView {
	
	init() {
		super.init(frame: .zero)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
	
	private func setupUI() {
		backgroundColor = .white
		layer.cornerRadius = 5
		layer.shadowColor = UIColor.white.cgColor
		layer.shadowRadius = 2
		layer.shadowOffset = .init(width: -2, height: 2)
		layer.shadowOpacity = 0.2
	}
}

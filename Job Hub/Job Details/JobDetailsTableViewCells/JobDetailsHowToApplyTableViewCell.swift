//
//  JobDetailsHowToApplyTableViewCell.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation
import UIKit

class JobDetailsHowToApplyTableViewCell: UITableViewCell {
	
	var howToApplyText: String = "" { didSet { onHowToApplyTextUpdate() } }
	
	private let howToApplyTitleLabel: UILabel = {
		let label = UILabel()
		label.text = R.string.localizable.jobDetailsHowToApply()
		label.setTextThemeType(.title3)
		return label
	}()
	
	private let howToApplyTextView: UITextView = {
		let textView = UITextView()
		textView.setTextThemeType(.body)
		textView.isEditable = false
		textView.isScrollEnabled = false
		textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
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
		
		contentView.addSubview(howToApplyTitleLabel)
		howToApplyTitleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(15)
			make.leading.equalToSuperview().offset(20)
			make.trailing.equalToSuperview().offset(-20)
		}
		
		contentView.addSubview(howToApplyTextView)
		howToApplyTextView.snp.makeConstraints { make in
			make.top.equalTo(howToApplyTitleLabel.snp.bottom).offset(10)
			make.bottom.equalToSuperview()
			make.leading.trailing.equalTo(howToApplyTitleLabel)
		}
	}
	
	private func onHowToApplyTextUpdate() {
		if let htmlAttributedString = howToApplyText.htmlToAttributedString {
			howToApplyTextView.attributedText = htmlAttributedString
				.withIncreasedFontSize(5)
		} else {
			howToApplyTextView.text = howToApplyText
		}
	}
}

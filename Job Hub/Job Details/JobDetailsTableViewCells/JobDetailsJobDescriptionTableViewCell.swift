//
//  JobDetailsJobDescriptionTableViewCell.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation
import UIKit

class JobDetailsJobDescriptionTableViewCell: UITableViewCell {
	
	var jobDescription: String = "" { didSet { onJobDescriptionUpdate() } }
	
	private let jobDescriptionTitleLabel: UILabel = {
		let label = UILabel()
		label.text = R.string.localizable.jobDetailsJobDescription()
		label.font = ThemeService.theme.headerFont
		return label
	}()
	
	private let jobDescriptionTextView: UITextView = {
		let textView = UITextView()
		textView.font = ThemeService.theme.bodyTextFont
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
		backgroundColor = .clear
		
		let wrapperView = JHTableViewCellWrapperView()
		contentView.addSubview(wrapperView)
		wrapperView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.leading.equalToSuperview().offset(10)
			make.trailing.equalToSuperview().offset(-10)
		}
		
		wrapperView.addSubview(jobDescriptionTitleLabel)
		jobDescriptionTitleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(15)
			make.leading.equalToSuperview().offset(20)
			make.trailing.equalToSuperview().offset(-20)
		}
		
		wrapperView.addSubview(jobDescriptionTextView)
		jobDescriptionTextView.snp.makeConstraints { make in
			make.top.equalTo(jobDescriptionTitleLabel.snp.bottom).offset(10)
			make.bottom.equalToSuperview()
			make.leading.trailing.equalTo(jobDescriptionTitleLabel)
		}
	}
	
	private func onJobDescriptionUpdate() {
		if let htmlAttributedString = jobDescription.htmlToAttributedString {
			jobDescriptionTextView.attributedText = htmlAttributedString
				.withIncreasedFontSize(5)
		} else {
			jobDescriptionTextView.text = jobDescription
		}
	}
}

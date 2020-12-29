//
//  JobDetailsMainDetailsTableViewCell.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation
import SnapKit
import UIKit

class JobDetailsMainDetailsTableViewCell: UITableViewCell {
	
	var jobTitle: String = "" { didSet { jobTitleLabel.text = jobTitle } }
	var companyName: String = "" { didSet { companyNameLabel.text = companyName } }
	var location: String = "" { didSet { locationLabel.text = location } }
	var companyImage: UIImage? = nil { didSet { updateCompanyImageViewSize() } }
	var publishDate: Date = .init() { didSet { publishDateLabel.text = publishDate.relativeString } }
	
	private var companyImageViewWidthConstraint: Constraint?
	private var companyImageViewHeightConstraint: Constraint?
	
	private let jobTitleLabel: UILabel = {
		let label = UILabel()
		label.setTextThemeType(.title2)
		label.numberOfLines = 0
		return label
	}()
	
	private let companyImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let companyNameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 2
		label.adjustsFontSizeToFitWidth = true
		label.setTextThemeType(.body)
		return label
	}()
	
	private let locationLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.setTextThemeType(.footnote)
		return label
	}()
	
	private let publishDateLabel: UILabel = {
		let label = UILabel()
		label.setTextThemeType(.caption1)
		return label
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
		
		contentView.addSubview(jobTitleLabel)
		jobTitleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(15)
			make.leading.equalToSuperview().offset(20)
			make.trailing.lessThanOrEqualToSuperview().offset(-20)
		}
		
		let companyWrapperView = UIView()
		contentView.addSubview(companyWrapperView)
		companyWrapperView.snp.makeConstraints { make in
			make.top.equalTo(jobTitleLabel.snp.bottom).offset(10)
			make.leading.equalTo(jobTitleLabel)
			make.trailing.lessThanOrEqualToSuperview().offset(-20)
		}
		
		companyWrapperView.addSubview(companyImageView)
		companyImageView.snp.makeConstraints { make in
			make.top.greaterThanOrEqualToSuperview()
			make.bottom.lessThanOrEqualToSuperview()
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview()
			
			companyImageViewWidthConstraint = make.width.equalTo(0).constraint
			companyImageViewHeightConstraint = make.height.equalTo(0).constraint
		}
		
		companyWrapperView.addSubview(companyNameLabel)
		companyNameLabel.snp.makeConstraints { make in
			make.top.greaterThanOrEqualToSuperview()
			make.bottom.lessThanOrEqualToSuperview()
			make.centerY.equalToSuperview()
			make.leading.equalTo(companyImageView.snp.trailing).offset(10)
			make.trailing.lessThanOrEqualToSuperview()
		}
		
		contentView.addSubview(publishDateLabel)
		publishDateLabel.snp.makeConstraints { make in
			make.top.equalTo(companyWrapperView.snp.bottom).offset(10)
			make.bottom.equalToSuperview().offset(-15)
			make.leading.equalTo(companyWrapperView)
			make.trailing.lessThanOrEqualToSuperview().offset(-20)
		}
		
		updateCompanyImageViewSize()
	}
	
	private func updateCompanyImageViewSize() {
		guard let image = self.companyImage ?? R.image.defaultCompanyLogo() else { return }
		companyImageView.image = image
		
		let maxWidth: CGFloat = frame.width / 4
		let maxHeight: CGFloat = 50
		
		let imageRatio = image.size.width / image.size.height
		let maxRatio = maxWidth / maxHeight
		
		if imageRatio > maxRatio {
			// maximize the available width then adjust the height
			let newHeight = maxWidth / imageRatio
			companyImageViewWidthConstraint?.update(offset: maxWidth)
			companyImageViewHeightConstraint?.update(offset: newHeight)
		} else {
			// maximize the available height then adjust the width
			let newWidth = maxHeight * imageRatio
			companyImageViewWidthConstraint?.update(offset: newWidth)
			companyImageViewHeightConstraint?.update(offset: maxHeight)
		}
	}
}

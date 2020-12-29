//
//  JobListTableViewCell.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/29/20.
//

import Foundation
import UIKit

class JobListTableViewCell: UITableViewCell {
	
	var jobTitle: String = "" { didSet { jobTitleLabel.text = jobTitle } }
	var companyName: String = "" { didSet { companyNameLabel.text = companyName } }
	var location: String = "" { didSet { locationLabel.text = location } }
	var companyImage: UIImage? = nil { didSet { companyImageView.image = companyImage ?? R.image.defaultCompanyLogo() } }
	var publishDate: Date = .init() { didSet { publishDateLabel.text = publishDate.relativeString } }
	
	private let jobTitleLabel: UILabel = {
		let label = UILabel()
		label.setTextThemeType(.headline)
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
		label.setTextThemeType(.subhead)
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
		
		contentView.addSubview(companyImageView)
		companyImageView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(15)
			make.leading.equalToSuperview().offset(10)
			make.width.height.equalTo(50)
		}
		
		contentView.addSubview(jobTitleLabel)
		jobTitleLabel.snp.makeConstraints { make in
			make.top.equalTo(companyImageView)
			make.leading.equalTo(companyImageView.snp.trailing).offset(10)
			make.trailing.lessThanOrEqualToSuperview().offset(-15)
		}
		
		contentView.addSubview(companyNameLabel)
		companyNameLabel.snp.makeConstraints { make in
			make.top.equalTo(jobTitleLabel.snp.bottom).offset(2)
			make.leading.equalTo(jobTitleLabel)
			make.trailing.lessThanOrEqualToSuperview().offset(-15)
		}
		
		contentView.addSubview(locationLabel)
		locationLabel.snp.makeConstraints { make in
			make.top.equalTo(companyNameLabel.snp.bottom).offset(2)
			make.leading.equalTo(companyNameLabel)
			make.trailing.lessThanOrEqualToSuperview().offset(-15)
		}
		
		contentView.addSubview(publishDateLabel)
		publishDateLabel.snp.makeConstraints { make in
			make.top.equalTo(locationLabel.snp.bottom).offset(3)
			make.bottom.equalToSuperview().offset(-15)
			make.leading.equalTo(locationLabel)
			make.trailing.lessThanOrEqualToSuperview().offset(-15)
		}
	}
}

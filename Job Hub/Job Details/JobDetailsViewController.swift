//
//  JobDetailsViewController.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation
import UIKit

class JobDetailsViewController: UIViewController {
	
	private let viewModel: JobDetailsViewModel
	
	private var items: [JobDetailsSectionItem] = [
		.mainDetails,
		.jobDescription,
		.howToApply
	]
	
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		tableView.backgroundColor = .clear
		tableView.showsVerticalScrollIndicator = false
		tableView.keyboardDismissMode = .onDrag
		tableView.allowsSelection = false
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 44
		
		// UITableViewCell registrations
		tableView.register(JobDetailsMainDetailsTableViewCell.self, forCellReuseIdentifier: JobDetailsMainDetailsTableViewCell.reuseIdentifier)
		tableView.register(JobDetailsJobDescriptionTableViewCell.self, forCellReuseIdentifier: JobDetailsJobDescriptionTableViewCell.reuseIdentifier)
		tableView.register(JobDetailsHowToApplyTableViewCell.self, forCellReuseIdentifier: JobDetailsHowToApplyTableViewCell.reuseIdentifier)
		
		return tableView
	}()
	
	init(job: Job) {
		self.viewModel = JobDetailsViewModel(job: job)
		super.init(nibName: nil, bundle: nil)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("The viewModel was not defined.")
	}
	
	private func setupUI() {
		view.backgroundColor = ThemeService.theme.backgroundColor
		
		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			let safeArea = self.view.safeAreaLayoutGuide
			make.top.equalTo(safeArea.snp.top)
			make.bottom.equalTo(safeArea.snp.bottom)
			
			make.leading.equalToSuperview().offset(15)
			make.trailing.equalToSuperview().offset(-15)
		}
		tableView.delegate = self
		tableView.dataSource = self
		
		viewModel.getJobDetails { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let job):
				DispatchQueue.main.async {
					self.title = job.title
					self.tableView.reloadData()
				}
			case .failure:
				break
			}
		}
	}
}

extension JobDetailsViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let job = viewModel.job else { return .init() }
		let item = items[indexPath.section]
		
		switch item {
		case .mainDetails:
			guard let cell = tableView.dequeueReusableCell(withIdentifier: JobDetailsMainDetailsTableViewCell.reuseIdentifier, for: indexPath) as? JobDetailsMainDetailsTableViewCell else { return .init() }
			cell.jobTitle = job.title
			cell.companyName = job.company
			cell.location = job.location
			cell.publishDate = Date.date(from: job.createdAt, withDateFormat: .expandedUTC) ?? .init()
			viewModel.getImage { result in
				switch result {
				case .success(let image):
					DispatchQueue.main.async {
						cell.companyImage = image
					}
				case .failure:
					break
				}
			}
			return cell
		case .jobDescription:
			guard let cell = tableView.dequeueReusableCell(withIdentifier: JobDetailsJobDescriptionTableViewCell.reuseIdentifier, for: indexPath) as? JobDetailsJobDescriptionTableViewCell else { return .init() }
			cell.jobDescription = job.description
			return cell
		case .howToApply:
			guard let cell = tableView.dequeueReusableCell(withIdentifier: JobDetailsHowToApplyTableViewCell.reuseIdentifier, for: indexPath) as? JobDetailsHowToApplyTableViewCell else { return .init() }
			cell.howToApplyText = job.howToApply
			return cell
		}
	}
}

extension JobDetailsViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if section == 0 { return 10 }
		return 5
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView()
		view.backgroundColor = .clear
		return view
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		if section == tableView.numberOfSections - 1 { return 10 }
		return 5
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let view = UIView()
		view.backgroundColor = .clear
		return view
	}
}

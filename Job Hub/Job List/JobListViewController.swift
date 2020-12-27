//
//  JobListViewController.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/28/20.
//

import Foundation
import SnapKit
import UIKit

class JobListViewController: UIViewController {
	
	private let viewModel = JobListViewModel()
	
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		tableView.backgroundColor = .clear
		tableView.showsVerticalScrollIndicator = true
		tableView.allowsSelection = false
		tableView.keyboardDismissMode = .onDrag
		tableView.bounces = false
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 44
		
		return tableView
	}()
	
	init() {
		super.init(nibName: nil, bundle: nil)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		ThemeService.theme.preferredStatusBarStyle
	}
	
	private func setupUI() {
		view.backgroundColor = ThemeService.theme.backgroundColor
		
		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			let safeArea = self.view.safeAreaLayoutGuide
			make.top.equalTo(safeArea.snp.top)
			make.bottom.equalTo(safeArea.snp.bottom)
			
			make.leading.trailing.equalToSuperview()
		}
		tableView.dataSource = self
		tableView.delegate = self
		
		pullDataFromTop()
	}
	
	private func pullDataFromTop() {
		viewModel.loadFirstPage { [weak self] result in
			switch result {
			case .success:
				DispatchQueue.main.async {
					self?.tableView.reloadData()
				}
			case .failure: break
			}
		}
	}
	
	private func pullDataFromBottom() {
		viewModel.loadNextPage { [weak self] result in
			switch result {
			case .success:
				DispatchQueue.main.async {
					self?.tableView.reloadData()
				}
			case .failure: break
			}
		}
	}
}

extension JobListViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.jobs.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let job = viewModel.jobs[indexPath.section]
		
		let cell = UITableViewCell()
		cell.textLabel?.text = job.title
		return cell
	}
}

extension JobListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 10
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView()
		view.backgroundColor = .clear
		return view
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 10
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let view = UIView()
		view.backgroundColor = .clear
		return view
	}
}

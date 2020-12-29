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
	
	private var tableViewIsBeingPulledUp = false
	private var isPullingData = false
	
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		tableView.backgroundColor = .clear
		tableView.showsVerticalScrollIndicator = true
		tableView.keyboardDismissMode = .onDrag
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 44
		
		return tableView
	}()
	
	private let topRefreshControl = UIRefreshControl()
	
	private let bottomSpinnerView: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: ThemeService.theme.activityIndicatorViewStyle)
		spinner.hidesWhenStopped = true
		return spinner
	}()
	
	init() {
		super.init(nibName: nil, bundle: nil)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
	
	private func setupUI() {
		title = R.string.localizable.jobListTitle()
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
		tableView.prefetchDataSource = self
		
		tableView.refreshControl = topRefreshControl // Loader on top
		topRefreshControl.addTarget(self, action: #selector(onPullDown), for: .valueChanged)
		tableView.tableFooterView = bottomSpinnerView // Loader at bottom
		
		pullDataFromTop()
	}
	
	@objc private func onPullDown() {
		pullDataFromTop()
	}
	
	private func pullDataFromTop() {
		guard !isPullingData else { return }
		isPullingData = true
		
		topRefreshControl.beginRefreshing()
		viewModel.loadFirstPage { [weak self] result in
			guard let self = self else { return }
			self.isPullingData = false
			self.topRefreshControl.endRefreshing()
			
			switch result {
			case .success(let jobs):
				guard !jobs.isEmpty else { return }
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			case .failure: break
			}
		}
	}
	
	private func pullDataFromBottom() {
		guard !isPullingData else { return }
		isPullingData = true
		
		bottomSpinnerView.startAnimating()
		viewModel.loadNextPage { [weak self] result in
			guard let self = self else { return }
			self.isPullingData = false
			self.bottomSpinnerView.stopAnimating()
			
			switch result {
			case .success(let jobs):
				guard !jobs.isEmpty else { return }
				DispatchQueue.main.async {
					self.tableView.reloadData()
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

extension JobListViewController: UITableViewDataSourcePrefetching {
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		guard let maxSection = indexPaths.map({ $0.section }).max(),
			  maxSection >= viewModel.jobs.count - 1
		else { return }
		
		pullDataFromBottom()
	}
}

extension JobListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let job = viewModel.jobs[indexPath.section]
		let jobDetailsViewController = JobDetailsViewController(job: job)
		navigationController?.pushViewController(jobDetailsViewController, animated: true)
	}
	
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

extension JobListViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if scrollView.contentOffset.y + scrollView.frame.size.height + bottomSpinnerView.frame.height >= scrollView.contentSize.height {
			if !tableViewIsBeingPulledUp {
				pullDataFromBottom()
			}
			tableViewIsBeingPulledUp = true
		} else {
			tableViewIsBeingPulledUp = false
		}
	}
}

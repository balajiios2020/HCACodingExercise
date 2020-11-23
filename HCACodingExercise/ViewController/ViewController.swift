//
//  ViewController.swift
//  HCACodingExercise
//
//  Created by Balaji Peddaiahgari on 11/22/20.
//  Copyright © 2020 Balaji Peddaiahgari. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

	private lazy var refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self,
								 action: #selector(fetchQuestions),
								 for: .valueChanged)
		return refreshControl
	}()

	private let activityIndicatorView: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.style = UIActivityIndicatorView.Style.large
		return indicator
	}()

	private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
		tableView.refreshControl = refreshControl
		tableView.register(QuestionTableViewCell.self,
                           forCellReuseIdentifier: Constants.reuseIdentifier)
        return tableView
    }()

	private var questions: [Question] = [] {
		didSet {
			tableView.reloadData()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Questions"
		let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh,
											target: self,
											action: #selector(fetchQuestions))
        navigationItem.rightBarButtonItem = refreshButton
		setupUI()
		fetchQuestions()
	}

	private func setupUI() {
		view.addSubview(tableView)
		view.addSubview(activityIndicatorView)
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		activityIndicatorView.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.height.width.equalTo(50)
		}
	}

	@objc private func fetchQuestions() {
		activityIndicatorView.startAnimating()
		NetworkManager.shared.fetchQuestions { [weak self] result in
			guard let self = self else { return }
			self.refreshControl.endRefreshing()
			self.activityIndicatorView.stopAnimating()
			self.activityIndicatorView.hidesWhenStopped = true
			switch result {
			case .success(let questions):
				let filteredQuestions = questions.filter {
					return $0.isAnswered && $0.answerCount > 1
				}
				self.questions = filteredQuestions
			case .failure(let error):
				let alert = UIAlertController(title: "Error",
											  message: error.localizedDescription,
											  preferredStyle: .alert)
				let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
				alert.addAction(okAction)
				self.present(alert, animated: true, completion: nil)
			}
		}
	}
}

extension ViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return questions.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath) as? QuestionTableViewCell else {
			fatalError()
		}
		let question = questions[indexPath.row]
		cell.configure(question: question.title,
					   answersCount: String(question.answerCount))
        return cell
	}
}

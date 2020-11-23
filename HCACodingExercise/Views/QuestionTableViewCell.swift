//
//  QuestionTableViewCell.swift
//  HCACodingExercise
//
//  Created by Balaji Peddaiahgari on 11/22/20.
//  Copyright © 2020 Balaji Peddaiahgari. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class QuestionTableViewCell: UITableViewCell {
	private let questionLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 18)
		return label
	}()

	private let answersLabel: UILabel = {
		let label = UILabel()
		label.text = "Answers:"
		label.font = .boldSystemFont(ofSize: 16)
		return label
	}()

	private let answersCountLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 16)
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupViews() {
		addSubview(questionLabel)
		addSubview(answersLabel)
		addSubview(answersCountLabel)
		questionLabel.snp.makeConstraints { make in
			make.left.right.top.equalToSuperview().inset(10)
		}
		answersLabel.snp.makeConstraints { make in
			make.left.equalTo(questionLabel)
			make.top.equalTo(questionLabel.snp.bottom).offset(5)
			make.bottom.equalToSuperview().offset(-5)
		}
		answersCountLabel.snp.makeConstraints { make in
			make.left.equalTo(answersLabel.snp.right).offset(10)
			make.centerY.equalTo(answersLabel)
		}
	}

	func configure(question: String, answersCount: String) {
		questionLabel.text = question
		answersCountLabel.text = answersCount
	}
}

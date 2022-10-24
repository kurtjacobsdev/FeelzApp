//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import UIKit

import FeelzCommonUI

public class EntriesListingCollectionViewCell: UICollectionViewCell {
    private var titleLabel = UILabel()
    private var notesLabel = UILabel()
    private var dateLabel = UILabel()
    private var labelStack = UIStackView()
    private var circleIconView = CircularStringView()
    private var contentStackView = UIStackView()

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        configureHierarchy()
        configureConstraints()
        configureStyling()
        configureProperties()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(configuration: EntriesListingCellConfiguration) {
        titleLabel.text = configuration.mood
        notesLabel.text = configuration.notes
        dateLabel.text = EntriesListingCellValueFormatter.format(date: configuration.date)
        circleIconView.configure(CircularStringViewConfiguration(title: Mood.mood(rawValue: configuration.mood)?.emoji ?? "", color: AppColor.primary))
    }

    private func configureHierarchy() {
        contentStackView.addArrangedSubview(circleIconView)
        labelStack.addArrangedSubview(dateLabel)
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(notesLabel)
        contentStackView.addArrangedSubview(labelStack)
        contentView.addSubview(contentStackView)
    }

    private func configureConstraints() {
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        circleIconView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
    }

    private func configureStyling() {
        dateLabel.font = .systemFont(ofSize: 20, weight: .bold)
        dateLabel.textColor = AppColor.primary
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        notesLabel.font = .systemFont(ofSize: 16, weight: .regular)
        notesLabel.numberOfLines = 2
    }

    private func configureProperties() {
        contentView.backgroundColor = AppColor.background
        contentView.layer.cornerRadius = 20
        contentStackView.spacing = 10
        contentStackView.alignment = .center
        labelStack.axis = .vertical
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/15.
//

import UIKit
import FeelzCommonUI

public class GreetingCollectionViewCell: UICollectionViewCell {
    private var messageLabel = UILabel()
    private var nameLabel = UILabel()
    private var labelStack = UIStackView()
    private var contentStack = UIStackView()
    private var iconView = CircularIconView()

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

    public func configure(configuration: GreetingCellConfiguration) {
        messageLabel.text = "Good \(configuration.timeOfDay.name)"
        nameLabel.text = configuration.name
        contentView.backgroundColor = .clear
        iconView.configure(CircularIconViewConfiguration(icon: configuration.timeOfDay.icon, color: configuration.color))
    }

    private func configureHierarchy() {
        labelStack.addArrangedSubview(messageLabel)
        labelStack.addArrangedSubview(nameLabel)
        contentStack.addArrangedSubview(iconView)
        contentStack.addArrangedSubview(labelStack)
        contentView.addSubview(contentStack)
    }

    private func configureConstraints() {
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        iconView.snp.makeConstraints {
            $0.width.equalTo(44)
            $0.height.equalTo(44)
        }
    }

    private func configureStyling() {
        messageLabel.font = .systemFont(ofSize: 36, weight: .bold)
        messageLabel.textColor = AppColor.background
        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        nameLabel.textColor = AppColor.background
    }

    private func configureProperties() {
        contentStack.spacing = 20
        contentStack.alignment = .center
        labelStack.axis = .vertical
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 20
        messageLabel.numberOfLines = 0
    }
}

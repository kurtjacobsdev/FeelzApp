//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/18.
//

import UIKit
import FeelzCommonUI

public class ActionCollectionViewCell: UICollectionViewCell {
    private var title = UILabel()
    private var circleIconView = CircularIconView()
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

    public func configure(configuration: ActionCellConfiguration) {
        title.text = configuration.title
        circleIconView.configure(CircularIconViewConfiguration(icon: configuration.imageURL, color: AppColor.primary))
    }

    private func configureHierarchy() {
        contentStackView.addArrangedSubview(circleIconView)
        contentStackView.addArrangedSubview(title)
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
        title.font = .systemFont(ofSize: 20, weight: .bold)
        title.textColor = AppColor.primary
        contentStackView.alignment = .center
    }

    private func configureProperties() {
        contentView.backgroundColor = AppColor.background
        contentView.layer.cornerRadius = 20
        contentStackView.spacing = 10
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/18.
//

import UIKit
import FeelzCommonUI

public class ExerciseCollectionViewCell: UICollectionViewCell {
    private var title = UILabel()
    private var subtitle = UILabel()
    private var typeView = CircularIconView()
    private var labelStack = UIStackView()
    private var contentStack = UIStackView()

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

    public func configure(configuration: ExerciseCellConfiguration) {
        title.text = configuration.title
        subtitle.text = configuration.subtitle
        switch configuration.type {
        case .journal:
            typeView.configure(CircularIconViewConfiguration(icon: "pencil.line", color: AppColor.primary))
        case .audio:
            typeView.configure(CircularIconViewConfiguration(icon: "waveform", color: AppColor.primary))
        }
    }

    private func configureHierarchy() {
        labelStack.addArrangedSubview(title)
        labelStack.addArrangedSubview(subtitle)
        contentStack.addArrangedSubview(typeView)
        contentStack.addArrangedSubview(labelStack)
        contentView.addSubview(contentStack)
    }

    private func configureConstraints() {
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        typeView.snp.makeConstraints {
            $0.width.equalTo(44)
            $0.height.equalTo(44)
        }
    }

    private func configureStyling() {
        title.font = .systemFont(ofSize: 20, weight: .bold)
        subtitle.font = .systemFont(ofSize: 14, weight: .medium)
        title.textColor = AppColor.primary
        subtitle.textColor = AppColor.primary
    }

    private func configureProperties() {
        contentView.backgroundColor = AppColor.background
        title.textAlignment = .left
        subtitle.textAlignment = .left
        subtitle.numberOfLines = 2
        contentStack.spacing = 10
        labelStack.axis = .vertical
        contentStack.alignment = .center
        contentStack.distribution = .fillProportionally
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 20
    }
}

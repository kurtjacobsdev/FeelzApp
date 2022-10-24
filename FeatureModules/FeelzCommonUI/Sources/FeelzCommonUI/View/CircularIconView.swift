//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/19.
//

import UIKit
import DynamicColor

public struct CircularIconViewConfiguration {
    var icon: String
    var color: UIColor

    public init(icon: String, color: UIColor) {
        self.icon = icon
        self.color = color
    }
}

public class CircularIconView: UIView {
    private var iconImageView = UIImageView()

    public init() {
        super.init(frame: .zero)
        configureHierarchy()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHierarchy() {
        self.addSubview(iconImageView)
    }

    private func configureConstraints() {
        iconImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }

    public func configure(_ configuration: CircularIconViewConfiguration) {
        iconImageView.image = UIImage(systemName: configuration.icon)
        iconImageView.tintColor = AppColor.background
        backgroundColor = configuration.color
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.masksToBounds = true
    }
}

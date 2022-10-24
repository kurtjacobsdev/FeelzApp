//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import UIKit

public struct CircularStringViewConfiguration {
    var title: String
    var color: UIColor

    public init(title: String, color: UIColor) {
        self.title = title
        self.color = color
    }
}

public class CircularStringView: UIView {
    private var label = UILabel()

    public init() {
        super.init(frame: .zero)
        configureHierarchy()
        configureConstraints()
        configureProperties()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHierarchy() {
        self.addSubview(label)
    }

    private func configureConstraints() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }

    private func configureProperties() {
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
    }

    public func configure(_ configuration: CircularStringViewConfiguration) {
        label.text = configuration.title
        backgroundColor = configuration.color
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.masksToBounds = true
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/10.
//

import UIKit
import NVActivityIndicatorView
import SnapKit

public struct AnimatedButtonConfiguration {
    var title: String
    var color: UIColor

    public init(title: String, color: UIColor) {
        self.title = title
        self.color = color
    }
}

public class AnimatedButton: UIView {
    private var button: UIButton = UIButton()
    private var loadingIndicator = NVActivityIndicatorView(frame: .zero)

    public init() {
        super.init(frame: .zero)
        configureHierarchy()
        configureConstraints()
        configureStyling()
        configureProperties()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHierarchy() {
        self.addSubview(button)
        self.addSubview(loadingIndicator)
    }

    private func configureStyling() {
        self.backgroundColor = AppColor.primary.withAlphaComponent(0.9)
        loadingIndicator.color = AppColor.secondary
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    }

    private func configureProperties() {
        loadingIndicator.type = .ballBeat
    }

    private func configureConstraints() {
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
    }

    public func configure(configuration: AnimatedButtonConfiguration) {
        button.setTitle(configuration.title, for: .normal)
    }

    public func addTarget(target: Any?, action: Selector, for event: UIControl.Event) {
        button.addTarget(target, action: action, for: event)
    }

    public func startAnimating() {
        loadingIndicator.startAnimating()
        button.isHidden = true
    }

    public func stopAnimating() {
        loadingIndicator.stopAnimating()
        button.isHidden = false
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2
        self.layer.masksToBounds = true
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import UIKit
import FeelzCommonUI

public protocol OnboardingIntroViewControllerDelegate: AnyObject {
    func didSelectNext(viewController: OnboardingIntroViewController)
}

public class OnboardingIntroViewController: UIViewController {
    private var viewModel: OnboardingIntroViewModel
    public weak var delegate: OnboardingIntroViewControllerDelegate?
    private var nextButton: AnimatedButton = AnimatedButton()
    private var titleLabel: UILabel = UILabel()
    private var iconView = CircularIconView()
    private var contentStack = UIStackView()

    public init(viewModel: OnboardingIntroViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureConstraints()
        configureProperties()
        configureStyling()
    }

    private func configureHierarchy() {
        view.addSubview(nextButton)
        contentStack.addArrangedSubview(iconView)
        contentStack.addArrangedSubview(titleLabel)
        view.addSubview(contentStack)
    }

    private func configureConstraints() {
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }

        contentStack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        iconView.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
    }

    private func configureStyling() {
        view.backgroundColor = AppColor.viewBackground
        titleLabel.textColor = AppColor.text
        titleLabel.font = .systemFont(ofSize: 60, weight: .bold)
        titleLabel.text = "Feelz"
        iconView.configure(CircularIconViewConfiguration(icon: "face.dashed.fill", color: AppColor.primary))
    }

    private func configureProperties() {
        nextButton.configure(configuration: AnimatedButtonConfiguration(title: "Start", color: .systemPurple))
        nextButton.addTarget(target: self, action: #selector(nextButtonSelected), for: .touchUpInside)
        contentStack.alignment = .center
        contentStack.spacing = 10
    }

    @objc func nextButtonSelected() {
        delegate?.didSelectNext(viewController: self)
    }
}

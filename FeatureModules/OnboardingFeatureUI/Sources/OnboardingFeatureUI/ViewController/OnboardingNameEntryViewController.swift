//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import UIKit
import SnapKit
import FeelzCommonUI
import Combine

public protocol OnboardingNameEntryViewControllerDelegate: AnyObject {
    func didCompleteSavingNameEntry(viewController: OnboardingNameEntryViewController)
}

public class OnboardingNameEntryViewController: UIViewController {
    private var viewModel: OnboardingNameEntryViewModel
    public weak var delegate: OnboardingNameEntryViewControllerDelegate?
    private var nextButton: AnimatedButton = AnimatedButton()
    private var usernameLabel: UILabel = UILabel()
    private var usernameTextField: RoundedTextField = RoundedTextField()
    private var userNameStackView: UIStackView = UIStackView()
    private var cancelBag: Set<AnyCancellable> = []

    public init(viewModel: OnboardingNameEntryViewModel) {
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
        configureBindings()
        hideKeyboardGesture()
    }

    private func configureHierarchy() {
        view.addSubview(nextButton)
        userNameStackView.addArrangedSubview(usernameLabel)
        userNameStackView.addArrangedSubview(usernameTextField)
        view.addSubview(userNameStackView)
    }

    private func configureConstraints() {
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }

        userNameStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }

        usernameTextField.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(60)
        }
    }

    private func configureStyling() {
        view.backgroundColor = AppColor.viewBackground
    }

    private func configureProperties() {
        nextButton.configure(configuration: AnimatedButtonConfiguration(title: "Next", color: .systemPurple))
        nextButton.addTarget(target: self, action: #selector(nextButtonSelected), for: .touchUpInside)
        userNameStackView.axis = .vertical
        userNameStackView.alignment = .center
        userNameStackView.distribution = .fill
        userNameStackView.spacing = 20
        usernameLabel.text = "Hi There 👋, what is your name?"
        usernameLabel.textColor = AppColor.text
        usernameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        usernameTextField.placeholder = "Name"
        usernameTextField.textAlignment = .center
    }

    @objc func nextButtonSelected() {
        Task {
            if try await viewModel.save(username: self.usernameTextField.text ?? "") {
                self.delegate?.didCompleteSavingNameEntry(viewController: self)
            } else {
                // Alert
            }
        }
    }

    private func configureBindings() {
        viewModel.$isSaving
            .receive(on: DispatchQueue.main)
            .sink { isSaving in
                if isSaving {
                    self.nextButton.startAnimating()
                } else {
                    self.nextButton.stopAnimating()
                }
            }.store(in: &cancelBag)
    }

    func hideKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

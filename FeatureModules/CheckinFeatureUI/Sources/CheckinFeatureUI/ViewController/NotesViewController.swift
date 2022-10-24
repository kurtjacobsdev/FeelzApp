//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/15.
//

import UIKit
import FeelzCommonUI

public protocol NotesViewControllerDelegate: AnyObject {
    func notesViewControllerDidFinish(viewController: NotesViewController)
}

public class NotesViewController: UIViewController {
    private var viewModel: NotesViewModel
    weak var delegate: NotesViewControllerDelegate?
    private var nextButton: AnimatedButton = AnimatedButton()
    private var textView: RoundedTextView = RoundedTextView()
    private var titleLabel = UILabel()

    public init(viewModel: NotesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureFeelzNavigationBar(title: "Notes")
        hideKeyboardGesture()
        configureHierarchy()
        configureConstraints()
        configureProperties()
        configureStyling()
        configureBarButtons()
    }

    private func configureHierarchy() {
        view.addSubview(nextButton)
        view.addSubview(textView)
        view.addSubview(titleLabel)
    }

    private func configureConstraints() {
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }

        textView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(300)
            $0.width.equalTo(300)
        }

        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(textView.snp.top).offset(-30)
            $0.left.right.equalToSuperview().inset(30)
        }
    }

    private func configureStyling() {}

    private func configureProperties() {
        nextButton.configure(configuration: AnimatedButtonConfiguration(title: "Next", color: .systemPurple))
        nextButton.addTarget(target: self, action: #selector(nextButtonSelected), for: .touchUpInside)
        titleLabel.textAlignment = .center
        titleLabel.text = "Capture some thoughts"
        titleLabel.textColor = AppColor.text
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.view.backgroundColor = AppColor.viewBackground
    }

    private func configureBarButtons() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close))
        barButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = barButton
    }

    @objc func close() {
        self.dismiss(animated: true)
    }

    @objc func nextButtonSelected() {
        viewModel.update(note: textView.text)
        delegate?.notesViewControllerDidFinish(viewController: self)
    }

    func hideKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

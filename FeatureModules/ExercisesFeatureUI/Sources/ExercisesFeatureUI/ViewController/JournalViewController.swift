//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/19.
//

import UIKit
import Combine
import FeelzCommonUI

public protocol JournalViewControllerDelegate: AnyObject {
    func didFinishJournalViewController()
}

public class JournalViewController: UIViewController {
    public weak var delegate: JournalViewControllerDelegate?
    private var viewModel: JournalViewModel
    private var comingSoonLabel = UILabel()

    public init(viewModel: JournalViewModel) {
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
        configureStyling()
        configureProperties()
        configureBarButtons()
        configureFeelzNavigationBar(title: "Journal")
    }

    private func configureHierarchy() {
        view.addSubview(comingSoonLabel)
    }

    private func configureConstraints() {
        comingSoonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func configureStyling() {
        comingSoonLabel.text = "Coming Soon"
        comingSoonLabel.textColor = AppColor.text
        comingSoonLabel.font = .systemFont(ofSize: 36, weight: .bold)
    }

    private func configureProperties() {
        view.backgroundColor = AppColor.viewBackground
    }

    private func configureBarButtons() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close))
        barButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = barButton
    }

    @objc func close() {
        self.dismiss(animated: true)
        delegate?.didFinishJournalViewController()
    }
}

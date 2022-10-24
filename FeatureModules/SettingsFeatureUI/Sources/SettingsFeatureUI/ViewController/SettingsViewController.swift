//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/19.
//

import UIKit
import Combine

public class SettingsViewController: UIViewController {
    private var viewModel: SettingsViewModel

    public init(viewModel: SettingsViewModel) {
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
    }

    private func configureHierarchy() {}

    private func configureConstraints() {}

    private func configureStyling() {}

    private func configureProperties() {
        view.backgroundColor = .red
    }

}

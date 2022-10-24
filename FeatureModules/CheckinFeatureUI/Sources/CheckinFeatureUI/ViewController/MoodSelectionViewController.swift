//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/15.
//

import UIKit
import FeelzCommonUI

public protocol MoodSelectionViewControllerDelegate: AnyObject {
    func moodSelectionCompleted(mood: Mood)
}

public class MoodSelectionViewController: UIViewController {
    private var viewModel: MoodSelectionViewModel
    weak var delegate: MoodSelectionViewControllerDelegate?
    private var moodSelectionBar = MoodSelectionBar()
    private var nextButton: AnimatedButton = AnimatedButton()

    public init(viewModel: MoodSelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureFeelzNavigationBar(title: "Mood")
        configureHierarchy()
        configureConstraints()
        configureProperties()
        configureStyling()
        configureBarButtons()
    }

    private func configureHierarchy() {
        view.addSubview(moodSelectionBar)
        view.addSubview(nextButton)
    }

    private func configureConstraints() {
        moodSelectionBar.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }

    private func configureStyling() {
        view.backgroundColor = AppColor.viewBackground
    }

    private func configureProperties() {
        nextButton.configure(configuration: AnimatedButtonConfiguration(title: "Next", color: .systemPurple))
        nextButton.addTarget(target: self, action: #selector(nextButtonSelected), for: .touchUpInside)
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
        guard let mood = moodSelectionBar.currentMood else { return }
        viewModel.update(mood: mood)
        delegate?.moodSelectionCompleted(mood: mood)
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import UIKit
import FeelzCommonUI
import Combine

public protocol CheckinSummaryViewControllerDelegate: AnyObject {
    func summaryViewControllerDidFinish(viewController: CheckinSummaryViewController)
}

public class CheckinSummaryViewController: UIViewController {
    private var viewModel: CheckinSummaryViewModel
    weak var delegate: CheckinSummaryViewControllerDelegate?
    private var nextButton: AnimatedButton = AnimatedButton()

    private var scrollView: UIScrollView = UIScrollView()
    private var moodIconView = CircularStringView()
    private var moodNameLabel = UILabel()
    private var noteLabel = RoundedLabel()
    private var dateLabel = UILabel()
    private var contentStack = UIStackView()
    private var cancelBag: Set<AnyCancellable> = []

    public init(viewModel: CheckinSummaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.viewBackground
        configureFeelzNavigationBar(title: "Summary")
        configureBarButtons()
        configureHierarchy()
        configureConstraints()
        configureProperties()
        configureBindings()
        viewModel.refresh()
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
        nextButton.startAnimating()
        Task {
            try await viewModel.save()
            nextButton.stopAnimating()
            delegate?.summaryViewControllerDidFinish(viewController: self)
        }
    }

    private func configureHierarchy() {
        contentStack.addArrangedSubview(moodIconView)
        contentStack.addArrangedSubview(moodNameLabel)
        contentStack.addArrangedSubview(dateLabel)
        contentStack.addArrangedSubview(noteLabel)
        contentStack.addArrangedSubview(UIView())
        scrollView.addSubview(contentStack)
        view.addSubview(scrollView)
        view.addSubview(nextButton)
    }

    private func configureConstraints() {
        contentStack.snp.makeConstraints {
            $0.left.right.equalTo(view).inset(20)
            $0.height.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(60)
        }

        moodIconView.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }

    private func configureProperties() {
        nextButton.configure(configuration: AnimatedButtonConfiguration(title: "Check-In", color: .systemPurple))
        nextButton.addTarget(target: self, action: #selector(nextButtonSelected), for: .touchUpInside)
        contentStack.axis = .vertical
        contentStack.alignment = .center
        contentStack.spacing = 20
        moodNameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        moodNameLabel.textColor = AppColor.text
        dateLabel.textColor = AppColor.text
        noteLabel.numberOfLines = 0
        scrollView.alwaysBounceVertical = true
    }

    private func configure(_ configuration: CheckinSummaryViewConfiguration) {
        moodIconView.configure(CircularStringViewConfiguration(title: Mood.mood(rawValue: configuration.mood)?.emoji ?? "", color: AppColor.primary))
        moodNameLabel.text = configuration.mood
        noteLabel.text = configuration.note
        dateLabel.text = CheckinSummaryViewValueFormatter.format(date: configuration.date)
    }

    private func configureBindings() {
        viewModel.$summary.receive(on: DispatchQueue.main).sink { configuration in
            guard let configuration = configuration else { return }
            self.configure(configuration)
        }.store(in: &cancelBag)
    }
}

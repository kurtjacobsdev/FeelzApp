//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/21.
//

import UIKit
import FeelzCommonUI
import Combine

public protocol EntriesDetailViewControllerDelegate: AnyObject {
    func didDeleteEntry(identifier: String)
    func didFinishEntriesDetailViewController()
}

public class EntriesDetailViewController: UIViewController {
    weak var delegate: EntriesDetailViewControllerDelegate?
    private var viewModel: EntriesDetailViewModel
    private var identifier: String

    private var scrollView: UIScrollView = UIScrollView()
    private var moodIconView = CircularStringView()
    private var moodNameLabel = UILabel()
    private var noteLabel = RoundedLabel()
    private var dateLabel = UILabel()
    private var contentStack = UIStackView()
    private var deleteButton = UIButton()
    private var cancelBag: Set<AnyCancellable> = []

    public init(viewModel: EntriesDetailViewModel, identifier: String) {
        self.viewModel = viewModel
        self.identifier = identifier
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureStyling()
        configureConstraints()
        configureProperties()
        configureBindings()
        configureFeelzNavigationBar(title: "Entry")
        configureBarButtons()
        viewModel.refresh(id: identifier)
    }

    private func configureHierarchy() {
        contentStack.addArrangedSubview(moodIconView)
        contentStack.addArrangedSubview(moodNameLabel)
        contentStack.addArrangedSubview(dateLabel)
        contentStack.addArrangedSubview(noteLabel)
        contentStack.addArrangedSubview(UIView())
        scrollView.addSubview(contentStack)
        view.addSubview(scrollView)
        view.addSubview(deleteButton)
    }

    private func configureConstraints() {
        contentStack.snp.makeConstraints {
            $0.left.right.equalTo(view).inset(20)
            $0.height.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(60)
        }

        deleteButton.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(100)
        }

        moodIconView.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureStyling() {
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
    }

    private func configureProperties() {
        self.view.backgroundColor = AppColor.viewBackground
        contentStack.axis = .vertical
        contentStack.alignment = .center
        contentStack.spacing = 20
        moodNameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        moodNameLabel.textColor = AppColor.text
        dateLabel.textColor = AppColor.text
        noteLabel.numberOfLines = 0
        scrollView.alwaysBounceVertical = true
    }

    public func configure(_ configuration: EntriesDetailViewConfiguration) {
        moodIconView.configure(CircularStringViewConfiguration(title: Mood.mood(rawValue: configuration.mood)?.emoji ?? "", color: AppColor.primary))
        moodNameLabel.text = configuration.mood
        noteLabel.text = configuration.note
        dateLabel.text = EntriesDetailsValueFormatter.format(date: configuration.date)
    }

    private func configureBindings() {
        viewModel.$detailsConfiguration.receive(on: DispatchQueue.main).sink { configuration in
            guard let configuration = configuration else { return }
            self.configure(configuration)
        }.store(in: &cancelBag)
    }

    @objc func deleteAction() {
        do {
            try viewModel.delete(id: identifier)
            delegate?.didDeleteEntry(identifier: identifier)
            self.dismiss(animated: true)
        } catch {
            print(error)
        }
    }

    private func configureBarButtons() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close))
        barButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = barButton
    }

    @objc func close() {
        self.dismiss(animated: true)
        delegate?.didFinishEntriesDetailViewController()
    }

}

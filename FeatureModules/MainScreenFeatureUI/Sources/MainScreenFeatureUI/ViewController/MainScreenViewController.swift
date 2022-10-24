//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/15.
//

import UIKit
import FeelzCommonUI
import SnapKit
import Combine
import NVActivityIndicatorView

typealias MainScreenDataSource = UICollectionViewDiffableDataSource<MainScreenSectionConfiguration, MainScreenItemConfiguration>
typealias MainScreenSnapshot = NSDiffableDataSourceSnapshot<MainScreenSectionConfiguration, MainScreenItemConfiguration>

public protocol MainScreenViewControllerDelegate: AnyObject {
    func didSelectAction(configuration: ActionCellConfiguration)
    func didSelectExercise(configuration: ExerciseCellConfiguration)
}

public class MainScreenViewController: UIViewController {
    weak var delegate: MainScreenViewControllerDelegate?
    private (set) public var viewModel: MainScreenViewModel
    private var collectionView: UICollectionView!
    private var cancelBag: Set<AnyCancellable> = []
    private var datasource: MainScreenDataSource?
    private var loadingIndicator = NVActivityIndicatorView(frame: .zero)

    public init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        configureCollectionView()
        createDataSource()
        configureProperties()
        configureHierarchy()
        configureConstraints()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.clearSnapshot()
        viewModel.refresh()
    }

    func createDataSource() {
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)

        let greetingCellRegistration = UICollectionView.CellRegistration<GreetingCollectionViewCell, GreetingCellConfiguration> { cell, _, configuration in
            cell.configure(configuration: configuration)
        }

        let actionCellRegistration = UICollectionView.CellRegistration<ActionCollectionViewCell, ActionCellConfiguration> { cell, _, configuration in
            cell.configure(configuration: configuration)
        }

        let exerciseCellRegistration = UICollectionView.CellRegistration<ExerciseCollectionViewCell, ExerciseCellConfiguration> { cell, _, configuration in
            cell.configure(configuration: configuration)
        }

        datasource = UICollectionViewDiffableDataSource<MainScreenSectionConfiguration, MainScreenItemConfiguration>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case let .greeting(item):
                return collectionView.dequeueConfiguredReusableCell(using: greetingCellRegistration, for: indexPath, item: item)
            case let .action(item):
                return collectionView.dequeueConfiguredReusableCell(using: actionCellRegistration, for: indexPath, item: item)
            case let .exercise(item):
                return collectionView.dequeueConfiguredReusableCell(using: exerciseCellRegistration, for: indexPath, item: item)
            }
        }

        datasource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView else {
                fatalError("Could not dequeue sectionHeader: \(SectionHeaderView.identifier)")
            }

            let title = self.viewModel.sections[indexPath.section].title
            let subtitle = self.viewModel.sections[indexPath.section].subtitle

            sectionHeader.title.text = title
            sectionHeader.subtitle.text = subtitle
            return sectionHeader
        }
    }

    private func refreshSnapshot() {
        var snapshot = MainScreenSnapshot()
        for section in viewModel.sections {
            snapshot.appendSections([section])
            snapshot.appendItems(section.items)
        }
        datasource?.apply(snapshot, animatingDifferences: false)
    }

    private func clearSnapshot() {
        guard var snapshot = datasource?.snapshot() else { return }
        snapshot.deleteAllItems()
        datasource?.apply(snapshot, animatingDifferences: false)
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
            let section = self.viewModel.sections[sectionIndex]
            switch section.type {
            case .greeting:
                return UICollectionViewLayout.createListLayout()
            case .action:
                return UICollectionViewLayout.createListLayout()
            case .exercise:
                return UICollectionViewLayout.createDualRowCarousel()
            }
        }))
        collectionView.delegate = self
    }

    private func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(100)
        }
    }

    private func configureProperties() {
        loadingIndicator.type = .ballPulse
        loadingIndicator.color = .systemPurple
        view.backgroundColor = AppColor.viewBackground
        collectionView.backgroundColor = AppColor.viewBackground
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = AppColor.background
    }

    private func configureHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)
    }

    private func configureBindings() {
        viewModel.$sections
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.refreshSnapshot()
        }.store(in: &cancelBag)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { isLoading in
                if isLoading {
                    self.loadingIndicator.startAnimating()
                } else {
                    self.loadingIndicator.stopAnimating()
                }
        }.store(in: &cancelBag)
    }
}

extension MainScreenViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = viewModel.sections[indexPath.section]
        guard let items = datasource?.snapshot(for: section).items else { return }
        let item = items[indexPath.row]
        switch item {
        case let .action(item):
            delegate?.didSelectAction(configuration: item)
        case let .exercise(item):
            delegate?.didSelectExercise(configuration: item)
        default:
            break
        }
    }
}

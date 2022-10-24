//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/19.
//

import UIKit
import FeelzCommonUI
import SnapKit
import Combine
import NVActivityIndicatorView

typealias EntriesDataSource = UICollectionViewDiffableDataSource<EntriesSection, EntriesItem>
typealias EntriesSnapshot = NSDiffableDataSourceSnapshot<EntriesSection, EntriesItem>

public protocol EntriesViewControllerDelegate: AnyObject {
    func didSelectCheckinItem(configuration: EntriesListingCellConfiguration)
}

public class EntriesViewController: UIViewController {
    weak var delegate: EntriesViewControllerDelegate?
    private (set) public var viewModel: EntriesViewModel
    private var collectionView: UICollectionView!
    private var cancelBag: Set<AnyCancellable> = []
    private var datasource: EntriesDataSource?
    private var loadingIndicator = NVActivityIndicatorView(frame: .zero)

    public init(viewModel: EntriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func refresh() {
        viewModel.refresh()
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
        self.refresh()
    }

    func createDataSource() {
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)

        let checkinCellRegistration = UICollectionView.CellRegistration<EntriesListingCollectionViewCell, EntriesListingCellConfiguration> { cell, _, configuration in
            cell.configure(configuration: configuration)
        }

        datasource = UICollectionViewDiffableDataSource<EntriesSection, EntriesItem>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case let .checkin(item):
                return collectionView.dequeueConfiguredReusableCell(using: checkinCellRegistration, for: indexPath, item: item)
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
        var snapshot = EntriesSnapshot()
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
            case .checkin:
                return UICollectionViewLayout.createListLayout()
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
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 20, right: 0)
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

extension EntriesViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = datasource?.itemIdentifier(for: indexPath)
        switch item {
        case let .checkin(configuration):
            delegate?.didSelectCheckinItem(configuration: configuration)
        default:
            break
        }
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/19.
//

import UIKit
import FeelzCommonUI

public protocol EntriesCoordinatorDependencies: EntriesViewModelDependencies, EntriesDetailViewModelDependencies { }

public class EntriesCoordinator {
    private let dependencies: EntriesCoordinatorDependencies
    private (set) public var navigationController: FeelzNavigationController = FeelzNavigationController()
    private lazy var entriesViewController: EntriesViewController = EntriesViewController(viewModel: EntriesViewModel(dependencies: dependencies))
    private var entriesDetailViewController: EntriesDetailViewController?

    public init(dependencies: EntriesCoordinatorDependencies) {
        self.dependencies = dependencies
        setup()
    }

    func setup() {
        entriesViewController.delegate = self
        navigationController.viewControllers = [entriesViewController]
        navigationController.tabBarItem.image = UIImage(systemName: "list.dash")
    }
}

extension EntriesCoordinator: EntriesDetailViewControllerDelegate {
    public func didDeleteEntry(identifier: String) {
        self.entriesViewController.refresh()
    }

    public func didFinishEntriesDetailViewController() {
        entriesDetailViewController = nil
    }
}

extension EntriesCoordinator: EntriesViewControllerDelegate {
    public func didSelectCheckinItem(configuration: EntriesListingCellConfiguration) {
        let viewController = EntriesDetailViewController(viewModel: EntriesDetailViewModel(dependencies: dependencies), identifier: configuration.id)
        viewController.delegate = self
        entriesDetailViewController = viewController
        let nav = FeelzNavigationController(rootViewController: viewController)
        navigationController.present(nav, animated: true)
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/15.
//

import UIKit
import CheckinFeatureDomain
import FeelzCommonUI

public protocol CheckinCoordinatorDependencies: MoodSelectionViewModelDependencies,
                                                NotesViewModelDependencies,
                                                CheckinSummaryViewModelDependencies {
}

public protocol CheckinCoordinatorDelegate: AnyObject {
    func didFinish(coordinator: CheckinCoordinator)
}

public class CheckinCoordinator {
    public weak var delegate: CheckinCoordinatorDelegate?
    private let dependencies: CheckinCoordinatorDependencies
    private (set) public var navigationController: UINavigationController = FeelzNavigationController()
    private lazy var moodSelectionViewController: MoodSelectionViewController = MoodSelectionViewController(viewModel: MoodSelectionViewModel(dependencies: dependencies))
    private var notesViewController: NotesViewController?
    private var summaryViewController: CheckinSummaryViewController?

    public init(dependencies: CheckinCoordinatorDependencies) {
        self.dependencies = dependencies
        setup()
    }

    func setup() {
        moodSelectionViewController.delegate = self
        navigationController.viewControllers = [moodSelectionViewController]
        navigationController.tabBarItem.title = "Checkin"
    }
}

extension CheckinCoordinator: MoodSelectionViewControllerDelegate {
    public func moodSelectionCompleted(mood: Mood) {
        let notesViewController = NotesViewController(viewModel: NotesViewModel(dependencies: dependencies))
        self.notesViewController = notesViewController
        notesViewController.delegate = self
        navigationController.pushViewController(notesViewController, animated: true)
    }
}

extension CheckinCoordinator: NotesViewControllerDelegate {
    public func notesViewControllerDidFinish(viewController: NotesViewController) {
        let summaryViewController = CheckinSummaryViewController(viewModel: CheckinSummaryViewModel(dependencies: dependencies))
        self.summaryViewController = summaryViewController
        summaryViewController.delegate = self
        navigationController.pushViewController(summaryViewController, animated: true)
    }
}

extension CheckinCoordinator: CheckinSummaryViewControllerDelegate {
    public func summaryViewControllerDidFinish(viewController: CheckinSummaryViewController) {
        navigationController.dismiss(animated: true)
        delegate?.didFinish(coordinator: self)
    }
}

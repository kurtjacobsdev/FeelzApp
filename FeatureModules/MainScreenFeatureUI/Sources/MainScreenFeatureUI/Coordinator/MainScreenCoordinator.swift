//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/15.
//

import UIKit

public protocol MainScreenCoordinatorDependencies: MainScreenViewModelDependencies {}

public protocol MainScreenCoordinatorDelegate: AnyObject {
    func didSelectCheckin(coordinator: MainScreenCoordinator)
    func didSelectJournal(coordinator: MainScreenCoordinator)
    func didSelectAudio(coordinator: MainScreenCoordinator)
}

public class MainScreenCoordinator {
    public weak var delegate: MainScreenCoordinatorDelegate?
    private var dependencies: MainScreenCoordinatorDependencies
    private (set) public var navigationController: UINavigationController = UINavigationController()

    private (set) public lazy var mainViewController: MainScreenViewController = MainScreenViewController(viewModel: MainScreenViewModel(dependencies: dependencies))

    public init(dependencies: MainScreenCoordinatorDependencies) {
        self.dependencies = dependencies
        setup()
    }

    func setup() {
        mainViewController.delegate = self
        navigationController.viewControllers = [mainViewController]
        navigationController.tabBarItem.title = "Main"
        navigationController.tabBarItem.image = UIImage(systemName: "house.fill")
    }
}

extension MainScreenCoordinator: MainScreenViewControllerDelegate {
    public func didSelectAction(configuration: ActionCellConfiguration) {
        switch configuration.type {
        case .checkin:
            delegate?.didSelectCheckin(coordinator: self)
        }
    }

    public func didSelectExercise(configuration: ExerciseCellConfiguration) {
        switch configuration.type {
        case .journal:
            delegate?.didSelectJournal(coordinator: self)
        case .audio:
            delegate?.didSelectAudio(coordinator: self)
        }
    }
}

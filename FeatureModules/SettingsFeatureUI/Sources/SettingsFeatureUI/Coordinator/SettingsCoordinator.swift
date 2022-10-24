//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/19.
//

import UIKit

public protocol SettingsCoordinatorDependencies { }

public class SettingsCoordinator {
    private let dependencies: SettingsCoordinatorDependencies
    private (set) public var navigationController: UINavigationController = UINavigationController()
    private var settingsViewController: SettingsViewController = SettingsViewController(viewModel: SettingsViewModel())

    public init(dependencies: SettingsCoordinatorDependencies) {
        self.dependencies = dependencies
        setup()
    }

    func setup() {
        navigationController.viewControllers = [settingsViewController]
        navigationController.tabBarItem.title = "Settings"
    }
}

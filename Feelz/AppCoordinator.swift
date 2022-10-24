//
//  AppCoordinator.swift
//  Feelz
//
//  Created by Kurt Jacobs on 2022/10/15.
//

import UIKit
import FeelzCommonUI
import MainScreenFeatureUI
import CheckinFeatureUI
import OnboardingFeatureUI
import SettingsFeatureUI
import ExercisesFeatureUI
import EntriesFeatureUI

protocol AppCoordinatorDependencies: CheckinFeatureDependencies,
                                     MainScreenFeatureDependencies,
                                     OnboardingFeatureDependencies,
                                     SettingsFeatureDependencies,
                                     ExercisesFeatureDependencies,
                                     EntriesFeatureDependencies {}

class AppCoordinator {
    private var dependencies: AppCoordinatorDependencies
    private (set) public lazy var tabBarController: UITabBarController = UITabBarController()

    // Features
    private lazy var mainScreenFeature: MainScreenFeature = MainScreenFeature(dependencies: dependencies)
    private lazy var checkinFeature: CheckinFeature = CheckinFeature(dependencies: dependencies)
    private lazy var onboardingFeature: OnboardingFeature = OnboardingFeature(dependencies: dependencies)
    private lazy var settingsFeature: SettingsFeature = SettingsFeature(dependencies: dependencies)
    private lazy var exercisesFeature: ExercisesFeature = ExercisesFeature(dependencies: dependencies)
    private lazy var entriesFeature: EntriesFeature = EntriesFeature(dependencies: dependencies)

    // Coordinators
    private var onboardingCoordinator: OnboardingCoordinator!
    private var mainScreenCoordinator: MainScreenCoordinator!
    private var checkinCoordinator: CheckinCoordinator!
    private var settingsCoordinator: SettingsCoordinator!
    private var exerciseCoordinator: ExercisesCoordinator!
    private var entriesCoordinator: EntriesCoordinator!

    init(dependencies: AppCoordinatorDependencies) {
        self.dependencies = dependencies
    }

    func setup() {
        mainScreenCoordinator = mainScreenFeature.coordinator()
        mainScreenCoordinator.delegate = self
        entriesCoordinator = entriesFeature.coordinator()

        tabBarController.viewControllers = [
            mainScreenCoordinator.navigationController,
            entriesCoordinator.navigationController
        ]
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.backgroundColor = AppColor.viewBackground.lighter(amount: 0.05)
        tabBarController.tabBar.unselectedItemTintColor = .white.darkened(amount: 0.25)
        tabBarController.tabBar.barTintColor = AppColor.viewBackground.lighter(amount: 0.05)
        tabBarController.tabBar.isTranslucent = false

        if !onboardingFeature.isCompleted() {
            onboardingCoordinator = onboardingFeature.coordinator()
            onboardingCoordinator.delegate = self
            onboardingCoordinator.navigationController.modalPresentationStyle = .overFullScreen
            tabBarController.present(onboardingCoordinator.navigationController, animated: false)
        }
    }
}

extension AppCoordinator: MainScreenCoordinatorDelegate {
    func didSelectCheckin(coordinator: MainScreenCoordinator) {
        checkinCoordinator = checkinFeature.coordinator()
        checkinCoordinator.navigationController.modalPresentationStyle = .automatic
        tabBarController.present(checkinCoordinator.navigationController, animated: true)
    }

    func didSelectJournal(coordinator: MainScreenCoordinator) {
        exerciseCoordinator = exercisesFeature.coordinator()
        exerciseCoordinator.navigationController.modalPresentationStyle = .automatic
        exerciseCoordinator.startJournal(identifier: "")
        tabBarController.present(exerciseCoordinator.navigationController, animated: true)
    }

    func didSelectAudio(coordinator: MainScreenCoordinator) {
        exerciseCoordinator = exercisesFeature.coordinator()
        exerciseCoordinator.navigationController.modalPresentationStyle = .automatic
        exerciseCoordinator.startAudio(identifier: "")
        tabBarController.present(exerciseCoordinator.navigationController, animated: true)
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    func didFinishOnboarding() {
        mainScreenCoordinator.mainViewController.viewModel.refresh()
        onboardingCoordinator = nil
    }
}

extension AppCoordinator: ExercisesCoordinatorDelegate {
    func didFinishExercise() {
        exerciseCoordinator = nil
    }
}

extension AppCoordinator: CheckinCoordinatorDelegate {
    func didFinish(coordinator: CheckinCoordinator) {
        checkinCoordinator = nil
    }
}

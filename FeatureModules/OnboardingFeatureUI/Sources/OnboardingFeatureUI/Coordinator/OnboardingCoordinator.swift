//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import UIKit

public protocol OnboardingCoordinatorDependencies: OnboardingNameEntryViewModelDependencies {}

public protocol OnboardingCoordinatorDelegate: AnyObject {
    func didFinishOnboarding()
}

public class OnboardingCoordinator {
    public weak var delegate: OnboardingCoordinatorDelegate?
    private (set) public var navigationController: UINavigationController = UINavigationController()
    private var dependencies: OnboardingCoordinatorDependencies
    private lazy var onboardingIntroViewController = OnboardingIntroViewController(viewModel: OnboardingIntroViewModel())
    private lazy var onboardingNameEntryViewController = OnboardingNameEntryViewController(viewModel: OnboardingNameEntryViewModel(dependencies: dependencies))

    public init(dependencies: OnboardingFeatureDependencies) {
        self.dependencies = dependencies
        setup()
    }

    func setup() {
        onboardingIntroViewController.delegate = self
        onboardingNameEntryViewController.delegate = self
        navigationController.viewControllers = [onboardingIntroViewController]
        navigationController.navigationItem.title = "Onboarding"
        navigationController.navigationBar.isHidden = true
    }
}

extension OnboardingCoordinator: OnboardingIntroViewControllerDelegate {
    public func didSelectNext(viewController: OnboardingIntroViewController) {
        let transition = CATransition()
        transition.type = .fade
        transition.subtype = .fromTop
        transition.duration = 0.3
        navigationController.view.layer.add(transition, forKey: kCATransition)
        navigationController.pushViewController(onboardingNameEntryViewController, animated: false)
    }
}

extension OnboardingCoordinator: OnboardingNameEntryViewControllerDelegate {
    public func didCompleteSavingNameEntry(viewController: OnboardingNameEntryViewController) {
        let transition = CATransition()
        transition.type = .fade
        transition.subtype = .fromTop
        transition.duration = 0.3
        navigationController.view.window?.layer.add(transition, forKey: kCATransition)
        delegate?.didFinishOnboarding()
        self.navigationController.dismiss(animated: false)
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import Foundation

public protocol OnboardingFeatureDependencies: OnboardingCoordinatorDependencies {}

public class OnboardingFeature {
    private var dependencies: OnboardingFeatureDependencies

    public init(dependencies: OnboardingFeatureDependencies) {
        self.dependencies = dependencies
    }

    public func coordinator() -> OnboardingCoordinator {
        return OnboardingCoordinator(dependencies: dependencies)
    }

    public func isCompleted() -> Bool {
        return dependencies.onboardingCompletionStatusUseCase.status()
    }

}

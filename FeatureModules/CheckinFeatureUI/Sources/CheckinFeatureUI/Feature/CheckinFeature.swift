//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/15.
//

import Foundation

public protocol CheckinFeatureDependencies: CheckinCoordinatorDependencies {}

public class CheckinFeature {
    private var dependencies: CheckinFeatureDependencies

    public init(dependencies: CheckinFeatureDependencies) {
        self.dependencies = dependencies
    }

    public func coordinator() -> CheckinCoordinator {
        return CheckinCoordinator(dependencies: dependencies)
    }
}

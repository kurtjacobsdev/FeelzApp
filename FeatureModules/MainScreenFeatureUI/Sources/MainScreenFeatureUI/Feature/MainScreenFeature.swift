//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/15.
//

import Foundation

public protocol MainScreenFeatureDependencies: MainScreenCoordinatorDependencies { }

public class MainScreenFeature {
    private var dependencies: MainScreenFeatureDependencies

    public init(dependencies: MainScreenFeatureDependencies) {
        self.dependencies = dependencies
    }

    public func coordinator() -> MainScreenCoordinator {
        return MainScreenCoordinator(dependencies: dependencies)
    }
}

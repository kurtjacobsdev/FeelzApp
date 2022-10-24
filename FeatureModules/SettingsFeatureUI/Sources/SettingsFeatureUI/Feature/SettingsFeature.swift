//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/19.
//

import Foundation

public protocol SettingsFeatureDependencies: SettingsCoordinatorDependencies {}

public class SettingsFeature {
    private var dependencies: SettingsFeatureDependencies

    public init(dependencies: SettingsFeatureDependencies) {
        self.dependencies = dependencies
    }

    public func coordinator() -> SettingsCoordinator {
        return SettingsCoordinator(dependencies: dependencies)
    }

}

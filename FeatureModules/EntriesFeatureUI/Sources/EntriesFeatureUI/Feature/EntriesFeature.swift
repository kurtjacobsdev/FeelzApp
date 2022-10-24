//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/19.
//

import Foundation

public protocol EntriesFeatureDependencies: EntriesCoordinatorDependencies {}

public class EntriesFeature {
    private var dependencies: EntriesFeatureDependencies

    public init(dependencies: EntriesFeatureDependencies) {
        self.dependencies = dependencies
    }

    public func coordinator() -> EntriesCoordinator {
        return EntriesCoordinator(dependencies: dependencies)
    }

}

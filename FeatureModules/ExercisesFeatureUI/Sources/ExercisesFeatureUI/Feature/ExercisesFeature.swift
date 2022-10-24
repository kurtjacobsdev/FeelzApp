//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/19.
//

import Foundation

public protocol ExercisesFeatureDependencies: ExercisesCoordinatorDependencies {}

public class ExercisesFeature {
    private var dependencies: ExercisesFeatureDependencies

    public init(dependencies: ExercisesFeatureDependencies) {
        self.dependencies = dependencies
    }

    public func coordinator() -> ExercisesCoordinator {
        return ExercisesCoordinator(dependencies: dependencies)
    }

}

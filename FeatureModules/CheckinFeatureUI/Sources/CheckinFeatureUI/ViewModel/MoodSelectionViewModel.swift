//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation
import CheckinFeatureDomain
import FeelzCommonUI

public protocol MoodSelectionViewModelDependencies {
    var moodCaptureUseCase: MoodCaptureUseCase { get set }
}

public class MoodSelectionViewModel {
    private var dependencies: MoodSelectionViewModelDependencies

    public init(dependencies: MoodSelectionViewModelDependencies) {
        self.dependencies = dependencies
    }

    public func update(mood: Mood) {
        dependencies.moodCaptureUseCase.store(mood: mood.title)
    }
}

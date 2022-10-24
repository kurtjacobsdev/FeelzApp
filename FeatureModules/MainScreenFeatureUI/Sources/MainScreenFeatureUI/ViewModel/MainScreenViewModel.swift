//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import Foundation
import MainScreenFeatureDomain
import FeelzCommonUI

public protocol MainScreenViewModelDependencies {
    var mainScreenUseCase: MainScreenUseCase { get }
}

public class MainScreenViewModel {
    private var dependencies: MainScreenViewModelDependencies
    @Published var sections: [MainScreenSectionConfiguration] = []
    @Published var isLoading: Bool = false

    public init(dependencies: MainScreenViewModelDependencies) {
        self.dependencies = dependencies
    }

    public func refresh() {
        Task {
            isLoading = true
            sections = try await dependencies.mainScreenUseCase.sections().map({$0.ui()})
            isLoading = false
        }
    }
}

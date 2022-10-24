//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import Foundation
import Combine
import OnboardingFeatureDomain

public protocol OnboardingNameEntryViewModelDependencies {
    var nameEntryUseCase: OnboardingNameEntryUseCase { get }
    var onboardingCompletionStatusUseCase: OnboardingCompletionStatusUseCase { get }
}

public class OnboardingNameEntryViewModel {
    private var dependencies: OnboardingNameEntryViewModelDependencies
    @Published var isSaving: Bool = false

    init(dependencies: OnboardingNameEntryViewModelDependencies) {
        self.dependencies = dependencies
    }

    public func save(username: String) async throws -> Bool {
        isSaving = true
        try await Task.sleep(nanoseconds: 1_500_000_000)
        _ = try await dependencies.nameEntryUseCase.save(name: username)
        _ = try await dependencies.onboardingCompletionStatusUseCase.save(completed: true)
        isSaving = false
        return true
    }
}

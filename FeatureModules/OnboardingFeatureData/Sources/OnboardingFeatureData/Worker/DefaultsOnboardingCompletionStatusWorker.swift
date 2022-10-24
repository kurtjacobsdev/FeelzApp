//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation
import FeelzCommonData
import OnboardingFeatureDomain

public class DefaultsOnboardingCompletionStatusWorker: OnboardingCompletionStatusWorker {
    private var storage: LocalStorage

    public init(storage: LocalStorage) {
        self.storage = storage
    }

    public func save(completed: Bool) async throws -> Bool {
        try storage.store(item: OnboardingStatus(completed: completed))
        return true
    }

    public func status() -> Bool {
        guard let status: OnboardingStatus = try? storage.fetch(objectForKey: .onboardingStatus) else { return false }
        return status.completed
    }
}

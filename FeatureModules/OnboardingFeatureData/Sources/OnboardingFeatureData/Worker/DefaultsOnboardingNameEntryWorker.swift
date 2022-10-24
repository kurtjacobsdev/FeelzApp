//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import Foundation
import OnboardingFeatureDomain
import FeelzCommonData

public class DefaultsOnboardingNameEntryWorker: OnboardingNameEntryWorker {
    private var storage: LocalStorage

    public init(storage: LocalStorage) {
        self.storage = storage
    }

    public func save(name: String) async throws -> Bool {
        try storage.store(item: Username(name: name))
        return true
    }
}

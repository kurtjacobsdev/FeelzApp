//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import Foundation

public class OnboardingNameEntryInteractor: OnboardingNameEntryUseCase {
    private var nameEntryWorker: OnboardingNameEntryWorker

    public init(nameEntryWorker: OnboardingNameEntryWorker) {
        self.nameEntryWorker = nameEntryWorker
    }

    public func save(name: String) async throws -> Bool {
        try await nameEntryWorker.save(name: name)
    }
}

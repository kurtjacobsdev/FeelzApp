//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation

public class OnboardingCompletionStatusInteractor: OnboardingCompletionStatusUseCase {
    private var completionStatusWorker: OnboardingCompletionStatusWorker

    public init(completionStatusWorker: OnboardingCompletionStatusWorker) {
        self.completionStatusWorker = completionStatusWorker
    }

    public func save(completed: Bool) async throws -> Bool {
        return try await completionStatusWorker.save(completed: completed)
    }

    public func status() -> Bool {
        return completionStatusWorker.status()
    }
}

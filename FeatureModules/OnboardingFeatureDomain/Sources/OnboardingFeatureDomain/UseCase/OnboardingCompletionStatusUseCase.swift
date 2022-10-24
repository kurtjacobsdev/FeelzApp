//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation

public protocol OnboardingCompletionStatusUseCase {
    func save(completed: Bool) async throws -> Bool
    func status() -> Bool
}

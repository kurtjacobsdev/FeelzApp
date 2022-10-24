//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import Foundation

public protocol OnboardingNameEntryWorker {
    func save(name: String) async throws -> Bool
}

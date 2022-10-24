//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import Foundation

public protocol MainScreenNameWorker {
    func get() async throws -> String?
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import Foundation

import MainScreenFeatureDomain
import FeelzCommonData

public class DefaultsMainScreenNameWorker: MainScreenNameWorker {
    private var storage: LocalStorage

    public init(storage: LocalStorage) {
        self.storage = storage
    }

    public func get() async throws -> String? {
        let username: Username? = try storage.fetch(objectForKey: .username)
        return username?.name
    }
}

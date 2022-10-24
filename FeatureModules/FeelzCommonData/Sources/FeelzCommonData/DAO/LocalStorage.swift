//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import Foundation

public enum LocalStorageItemKey: String {
    case username
    case onboardingStatus
}

public protocol LocalStorageItem: Codable {
    static var key: LocalStorageItemKey { get set }
}

public protocol LocalStorage {
    func store<Item: LocalStorageItem>(item: Item) throws
    func fetch<Item: LocalStorageItem>(objectForKey key: LocalStorageItemKey) throws -> Item?
}

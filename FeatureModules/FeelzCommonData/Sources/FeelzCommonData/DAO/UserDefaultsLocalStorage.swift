//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import Foundation

public class UserDefaultsLocalStorage: LocalStorage {
    private var userDefaults: UserDefaults = .standard

    public init() {}

    public func store<Item: LocalStorageItem>(item: Item) throws {
        let jsonItem = try JSONEncoder().encode(item)
        userDefaults.set(jsonItem, forKey: Item.key.rawValue)
    }

    public func fetch<Item: LocalStorageItem>(objectForKey key: LocalStorageItemKey) throws -> Item? {
        guard let data = userDefaults.data(forKey: key.rawValue) else { return nil }
        let json = try JSONDecoder().decode(Item.self, from: data)
        return json
    }
}

public struct Username: LocalStorageItem {
    public static var key: LocalStorageItemKey = .username
    public var name: String

    public init(name: String) {
        self.name = name
    }
}

public struct OnboardingStatus: LocalStorageItem {
    public static var key: LocalStorageItemKey = .onboardingStatus
    public var completed: Bool

    public init(completed: Bool) {
        self.completed = completed
    }
}

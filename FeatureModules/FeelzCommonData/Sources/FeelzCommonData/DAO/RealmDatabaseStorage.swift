//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation
import RealmSwift

public class RealmDatabaseStorage: DatabaseStorage {
    private var realmQueue: DispatchQueue = DispatchQueue(label: "rq")
    private var realm: Realm?

    public init() {
        realmQueue.sync { realm = try? Realm(queue: realmQueue) }
    }

    public func fetch<Entity>(entity: Entity.Type, id: String) -> Entity? where Entity: Object {
        var out: ThreadSafeReference<Entity>?
        realmQueue.sync {
            guard let item = realm?.object(ofType: entity.self, forPrimaryKey: id) else { return }
            out = ThreadSafeReference(to: item)
        }
        guard let out = out else { return nil }
        let mRealm = try? Realm()
        return mRealm?.resolve(out)
    }

    public func fetch<Entity>(entities: Entity.Type) -> [Entity] where Entity: Object {
        var threadSafeItems: [ThreadSafeReference<Entity>] = []
        realmQueue.sync {
            let items = realm?.objects(entities.self).compactMap({ $0 }).map({ ThreadSafeReference(to: $0) }) ?? []
            threadSafeItems = items
        }
        let mRealm = try? Realm()
        let items = threadSafeItems.compactMap({ mRealm?.resolve($0) })
        return items
    }

    public func save<Entity>(entity: Entity) throws where Entity: Object {
        realmQueue.sync {
            self.realm?.beginWrite()
            self.realm?.add(entity)
            try? self.realm?.commitWrite()
        }
    }

    public func delete<Entity>(entity: Entity.Type, id: String) throws where Entity: Object {
        try realmQueue.sync {
            guard let entity = realm?.object(ofType: entity.self, forPrimaryKey: id) else {
                throw RealmDatabaseStorageError.objectNotFound
            }
            self.realm?.beginWrite()
            self.realm?.delete(entity)
            try? self.realm?.commitWrite()
        }
    }
}

public enum RealmDatabaseStorageError: Error {
    case objectNotFound
}

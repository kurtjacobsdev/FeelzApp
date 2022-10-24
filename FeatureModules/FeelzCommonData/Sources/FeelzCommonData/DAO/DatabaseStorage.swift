//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import Foundation
import RealmSwift

public protocol DatabaseStorage {
    func fetch<Entity: Object>(entity: Entity.Type, id: String) -> Entity?
    func fetch<Entity: Object>(entities: Entity.Type) -> [Entity]
    func save<Entity: Object>(entity: Entity) throws
    func delete<Entity: Object>(entity: Entity.Type, id: String) throws
}

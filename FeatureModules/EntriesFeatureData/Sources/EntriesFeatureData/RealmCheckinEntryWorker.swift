//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation
import EntriesFeatureDomain
import FeelzCommonData

public class RealmCheckinEntryWorker: CheckinEntryWorker {
    private var database: DatabaseStorage

    public init(database: DatabaseStorage) {
        self.database = database
    }

    public func fetch() -> [Checkin] {
        let entities = database.fetch(entities: CheckinDTO.self).map { $0.entity() }
        return entities
    }
}

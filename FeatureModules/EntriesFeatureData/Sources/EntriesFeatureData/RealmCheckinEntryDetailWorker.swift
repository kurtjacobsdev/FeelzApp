//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/21.
//

import Foundation
import FeelzCommonData
import EntriesFeatureDomain

public class RealmCheckinEntryDetailWorker: CheckinEntryDetailWorker {
    private var database: DatabaseStorage

    public init(database: DatabaseStorage) {
        self.database = database
    }

    public func fetch(identifier: String) -> Checkin? {
        let entity = database.fetch(entity: CheckinDTO.self, id: identifier).map { $0.entity() }
        return entity
    }

    public func delete(identifier: String) throws {
        try database.delete(entity: CheckinDTO.self, id: identifier)
    }
}

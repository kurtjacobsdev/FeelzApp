//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation
import RealmSwift
import FeelzCommonData
import CheckinFeatureDomain

public class RealmCheckinWorker: CheckinWorker {
    private var database: DatabaseStorage

    public init(database: DatabaseStorage) {
        self.database = database
    }

    public func save(checkin: Checkin) throws {
        try database.save(entity: checkin.dto())
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation
import RealmSwift

public class CheckinDTO: Object {
    @Persisted(primaryKey: true) public var id: String
    @Persisted public var mood: String
    @Persisted public var notes: String
    @Persisted public var date: Date
}

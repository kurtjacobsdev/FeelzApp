//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/21.
//

import Foundation
import EntriesFeatureDomain

public struct EntriesDetailViewConfiguration {
    public var id: String
    public var mood: String
    public var note: String?
    public var date: Date

    public init(id: String, mood: String, note: String? = nil, date: Date) {
        self.mood = mood
        self.note = note
        self.date = date
        self.id = id
    }
}

extension Checkin {
    func configuration() -> EntriesDetailViewConfiguration {
        return EntriesDetailViewConfiguration(id: id, mood: mood, note: notes, date: date)
    }
}

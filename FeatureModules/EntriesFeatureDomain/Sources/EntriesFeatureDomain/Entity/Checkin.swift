//
//  File 2.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation

public struct Checkin {
    public var id: String
    public var mood: String
    public var notes: String
    public var date: Date

    public init(id: String, mood: String, notes: String, date: Date) {
        self.id = id
        self.mood = mood
        self.notes = notes
        self.date = date
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation

public enum EntriesListingCellConfigurationType {
    case checkin
}

public struct EntriesListingCellConfiguration: Hashable, Identifiable {
    public var id: String
    public var mood: String
    public var notes: String
    public var date: Date
    public var imageURL: String
    public var type: EntriesListingCellConfigurationType

    public init(id: String, mood: String, notes: String, date: Date, imageURL: String, type: EntriesListingCellConfigurationType) {
        self.id = id
        self.mood = mood
        self.notes = notes
        self.date = date
        self.imageURL = imageURL
        self.type = type
    }
}

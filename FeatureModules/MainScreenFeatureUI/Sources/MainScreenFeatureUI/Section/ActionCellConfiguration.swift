//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/18.
//

import Foundation

public enum ActionCellConfigurationType {
    case checkin
}

public struct ActionCellConfiguration: Hashable, Identifiable {
    public var id: UUID = { return UUID() }()
    public var title: String
    public var subtitle: String
    public var imageURL: String
    public var type: ActionCellConfigurationType

    public init(title: String, subtitle: String, imageURL: String, type: ActionCellConfigurationType) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.type = type
    }
}

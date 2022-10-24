//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import Foundation

public enum ActionSectionItemType {
    case checkin
}

public struct ActionSectionItem {
    public var title: String
    public var subtitle: String
    public var imageURL: String
    public var type: ActionSectionItemType

    public init(title: String, subtitle: String, imageURL: String, type: ActionSectionItemType) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.type = type
    }
}

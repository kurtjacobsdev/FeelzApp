//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import Foundation

public enum ExerciseSectionItemType {
    case journal
    case audio
}

public struct ExerciseSectionItem {
    public var title: String
    public var subtitle: String
    public var imageURL: String
    public var type: ExerciseSectionItemType

    public init(title: String, subtitle: String, imageURL: String, type: ExerciseSectionItemType) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.type = type
    }
}

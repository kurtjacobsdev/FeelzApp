//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/18.
//

import Foundation

public enum ExerciseCellConfigurationType {
    case journal
    case audio
}

public struct ExerciseCellConfiguration: Hashable, Identifiable {
    public var id: UUID = { return UUID() }()
    public var title: String
    public var subtitle: String
    public var imageURL: String
    public var type: ExerciseCellConfigurationType

    public init(title: String, subtitle: String, imageURL: String, type: ExerciseCellConfigurationType) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.type = type
    }
}

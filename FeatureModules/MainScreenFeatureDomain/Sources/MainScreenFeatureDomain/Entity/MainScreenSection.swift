//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import Foundation
import FeelzCommonDomain

public enum MainScreenItem {
    case greeting(GreetingSectionItem)
    case action(ActionSectionItem)
    case exercise(ExerciseSectionItem)
}

public enum MainScreenSectionType {
    case greeting
    case action
    case exercise
}

public struct MainScreenSection {
    public let items: [MainScreenItem]
    public let title: String?
    public let subtitle: String?
    public let type: MainScreenSectionType

    public init(items: [MainScreenItem], title: String? = nil, subtitle: String? = nil, type: MainScreenSectionType) {
        self.items = items
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
}

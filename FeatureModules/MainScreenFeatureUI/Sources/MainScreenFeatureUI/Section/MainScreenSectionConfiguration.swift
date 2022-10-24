//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/18.
//

import UIKit
import MainScreenFeatureDomain
import FeelzCommonUI

public enum MainScreenItemConfiguration: Hashable {
    case greeting(GreetingCellConfiguration)
    case action(ActionCellConfiguration)
    case exercise(ExerciseCellConfiguration)
}

public enum MainScreenSectionConfigurationType {
    case greeting
    case action
    case exercise
}

public struct MainScreenSectionConfiguration: Hashable, Identifiable {
    public let id: UUID = { return UUID() }()
    public let items: [MainScreenItemConfiguration]
    public let title: String?
    public let subtitle: String?
    public let type: MainScreenSectionConfigurationType

    public init(items: [MainScreenItemConfiguration], title: String? = nil, subtitle: String? = nil, type: MainScreenSectionConfigurationType) {
        self.items = items
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import Foundation
import MainScreenFeatureDomain
import FeelzCommonUI

extension MainScreenSection {
    func ui() -> MainScreenSectionConfiguration {
        return MainScreenSectionConfiguration(items: items.map { $0.ui() }, title: title, subtitle: subtitle, type: self.type.ui())
    }
}

extension MainScreenItem {
    func ui() -> MainScreenItemConfiguration {
        switch self {
        case let .greeting(item):
            return .greeting(item.ui())
        case let .action(item):
            return .action(item.ui())
        case let .exercise(item):
            return .exercise(item.ui())
        }
    }
}

extension GreetingSectionItem {
    func ui() -> GreetingCellConfiguration {
        return GreetingCellConfiguration(timeOfDay: timeOfDay.ui(), name: name, color: AppColor.primary)
    }
}

extension ExerciseSectionItem {
    func ui() -> ExerciseCellConfiguration {
        return ExerciseCellConfiguration(title: title, subtitle: subtitle, imageURL: imageURL, type: type.ui())
    }
}

extension ActionSectionItem {
    func ui() -> ActionCellConfiguration {
        return ActionCellConfiguration(title: title, subtitle: subtitle, imageURL: imageURL, type: type.ui())
    }
}

extension ExerciseSectionItemType {
    func ui() -> ExerciseCellConfigurationType {
        switch self {
        case .audio:
            return .audio
        case .journal:
            return .journal
        }
    }
}

extension ActionSectionItemType {
    func ui() -> ActionCellConfigurationType {
        switch self {
        case .checkin:
            return .checkin
        }
    }
}

extension MainScreenSectionType {
    func ui() -> MainScreenSectionConfigurationType {
        switch self {
        case .greeting:
            return .greeting
        case .action:
            return .action
        case .exercise:
            return .exercise
        }
    }
}

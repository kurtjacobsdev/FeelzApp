//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import Foundation
import FeelzCommonDomain

public enum TimeOfDay {
    case morning
    case afternoon
    case evening
    case none
}

public extension FeelzCommonDomain.TimeOfDay {
    func ui() -> TimeOfDay {
        switch self {
        case .none:
            return .none
        case .evening:
            return .evening
        case .afternoon:
            return .afternoon
        case .morning:
            return .morning
        }
    }
}

public extension TimeOfDay {
    var name: String {
        switch self {
        case .morning:
            return "morning"
        case .afternoon:
            return "afternoon"
        case .evening:
            return "evening"
        case .none:
            return ""
        }
    }

    var icon: String {
        switch self {
        case .morning:
            return "sun.max.fill"
        case .afternoon:
            return "sun.haze.fill"
        case .evening:
            return "moon.fill"
        case .none:
            return ""
        }
    }
}

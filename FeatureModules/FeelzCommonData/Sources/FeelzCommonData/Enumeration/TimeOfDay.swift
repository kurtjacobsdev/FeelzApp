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

public extension TimeOfDay {
    func domain() -> FeelzCommonDomain.TimeOfDay {
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

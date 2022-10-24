//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import Foundation
import MainScreenFeatureDomain
import FeelzCommonData
import FeelzCommonDomain

public class LocalMainScreenTimeOfDayWorker: MainScreenTimeOfDayWorker {
    public init() {}

    public func get(date: Date = Date()) -> FeelzCommonDomain.TimeOfDay {
        let hour = Calendar.current.component(.hour, from: date)
        switch hour {
        case 0..<12:
            return .morning
        case 12..<19:
            return .afternoon
        case 19..<25:
            return .evening
        default:
            return .none
        }
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import Foundation
import FeelzCommonDomain

public struct GreetingSectionItem {
    public var timeOfDay: TimeOfDay
    public var name: String

    public init(timeOfDay: TimeOfDay, name: String) {
        self.timeOfDay = timeOfDay
        self.name = name
    }
}

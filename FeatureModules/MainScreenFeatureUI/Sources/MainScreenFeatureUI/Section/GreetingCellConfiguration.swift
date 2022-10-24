//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/18.
//

import Foundation
import UIKit
import FeelzCommonUI

public struct GreetingCellConfiguration: Hashable, Identifiable {
    public var id: UUID = { return UUID() }()
    public var timeOfDay: TimeOfDay
    public var name: String
    public var color: UIColor

    public init(timeOfDay: TimeOfDay, name: String, color: UIColor) {
        self.timeOfDay = timeOfDay
        self.name = name
        self.color = color
    }
}

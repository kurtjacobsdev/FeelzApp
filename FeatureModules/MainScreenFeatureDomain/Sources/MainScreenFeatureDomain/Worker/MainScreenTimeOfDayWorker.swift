//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import Foundation
import FeelzCommonDomain

public protocol MainScreenTimeOfDayWorker {
    func get(date: Date) -> TimeOfDay
}

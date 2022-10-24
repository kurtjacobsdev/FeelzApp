//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import Foundation
import CheckinFeatureDomain

public struct CheckinSummaryViewConfiguration {
    public var mood: String
    public var note: String?
    public var date: Date

    public init(mood: String, note: String? = nil, date: Date) {
        self.mood = mood
        self.note = note
        self.date = date
    }
}

extension CheckinInteractorState {
    func configuration() -> CheckinSummaryViewConfiguration {
        return CheckinSummaryViewConfiguration(mood: mood ?? "", note: note ?? "", date: date)
    }
}

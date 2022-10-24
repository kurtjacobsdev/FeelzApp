//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation
import CheckinFeatureDomain
import FeelzCommonData

extension Checkin {
    func dto() -> CheckinDTO {
        let dto = CheckinDTO()
        dto.date = date
        dto.id = id
        dto.notes = notes
        dto.mood = mood
        return dto
    }
}

extension CheckinDTO {
    func entity() -> Checkin {
        return Checkin(id: id, mood: mood, notes: notes, date: date)
    }
}

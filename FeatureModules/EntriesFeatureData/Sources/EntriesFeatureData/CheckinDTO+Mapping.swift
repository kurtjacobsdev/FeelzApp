//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation
import FeelzCommonData
import EntriesFeatureDomain

extension CheckinDTO {
    func entity() -> Checkin {
        return Checkin(id: id, mood: mood, notes: notes, date: date)
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation

public class EntriesListingInteractor: EntriesListingUseCase {
    private var checkinEntryWorker: CheckinEntryWorker

    public init(checkinEntryWorker: CheckinEntryWorker) {
        self.checkinEntryWorker = checkinEntryWorker
    }

    public func fetch() -> [Checkin] {
        return checkinEntryWorker.fetch().sorted(by: { $0.date > $1.date })
    }
}

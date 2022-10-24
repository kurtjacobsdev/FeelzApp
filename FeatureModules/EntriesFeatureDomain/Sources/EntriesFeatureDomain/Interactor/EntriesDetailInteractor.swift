//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/21.
//

import Foundation

public class EntriesDetailInteractor: EntriesDetailUseCase {
    private var checkinEntryDetailWorker: CheckinEntryDetailWorker

    public init(checkinEntryDetailWorker: CheckinEntryDetailWorker) {
        self.checkinEntryDetailWorker = checkinEntryDetailWorker
    }

    public func get(identifier: String) -> Checkin? {
        return checkinEntryDetailWorker.fetch(identifier: identifier)
    }

    public func delete(identifier: String) throws {
        try checkinEntryDetailWorker.delete(identifier: identifier)
    }
}

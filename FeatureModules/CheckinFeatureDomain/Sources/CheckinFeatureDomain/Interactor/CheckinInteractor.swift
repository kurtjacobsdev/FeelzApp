//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation

public struct CheckinInteractorState {
    public var mood: String?
    public var note: String?
    public var date: Date
}

public class CheckinInteractor: CheckinSummaryUseCase {
    private var checkinWorker: CheckinWorker
    private var mood: String?
    private var note: String?

    public init(checkinWorker: CheckinWorker) {
        self.checkinWorker = checkinWorker
    }

    public func save() async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        try checkinWorker.save(checkin: Checkin(id: UUID().uuidString,
                                                mood: mood ?? "",
                                                notes: note ?? "",
                                                date: Date()))
    }

    public func get() -> CheckinInteractorState {
        CheckinInteractorState(mood: self.mood, note: self.note, date: Date())
    }
}

extension CheckinInteractor: MoodCaptureUseCase {
    public func store(mood: String) {
        self.mood = mood
    }
}

extension CheckinInteractor: NotesCaptureUseCase {
    public func store(note: String) {
        self.note = note
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/19.
//

import Foundation
import EntriesFeatureDomain

public protocol EntriesViewModelDependencies {
    var entriesListingUseCase: EntriesListingUseCase { get set }
}

public class EntriesViewModel {
    private var dependencies: EntriesViewModelDependencies
    @Published var sections: [EntriesSection] = []
    @Published var isLoading: Bool = false

    public init(dependencies: EntriesViewModelDependencies) {
        self.dependencies = dependencies
    }

    public func refresh() {
        isLoading = true
        let checkins = dependencies.entriesListingUseCase.fetch()
        let items = checkins.map {
            EntriesItem.checkin(EntriesListingCellConfiguration(id: $0.id, mood: $0.mood, notes: $0.notes, date: $0.date, imageURL: "square.and.pencil.circle.fill", type: .checkin))
        }
        sections = [
            EntriesSection(items: items, title: "Entries", subtitle: "A list of all checkins", type: .checkin)
        ]
        isLoading = false
    }
}

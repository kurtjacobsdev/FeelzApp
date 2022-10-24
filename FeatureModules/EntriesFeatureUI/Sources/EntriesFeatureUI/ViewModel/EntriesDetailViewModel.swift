//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/21.
//

import Foundation
import EntriesFeatureDomain

public protocol EntriesDetailViewModelDependencies {
    var entriesDetailUseCase: EntriesDetailUseCase { get set }
}

public class EntriesDetailViewModel {
    private var dependencies: EntriesDetailViewModelDependencies
    @Published var detailsConfiguration: EntriesDetailViewConfiguration?
    @Published var isLoading: Bool = false

    public init(dependencies: EntriesDetailViewModelDependencies) {
        self.dependencies = dependencies
    }

    public func refresh(id: String) {
        isLoading = true
        detailsConfiguration = dependencies.entriesDetailUseCase.get(identifier: id).map { $0.configuration() }
        isLoading = false
    }

    public func delete(id: String) throws {
        try dependencies.entriesDetailUseCase.delete(identifier: id)
    }
}

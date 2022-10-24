//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation
import CheckinFeatureDomain

public protocol CheckinSummaryViewModelDependencies {
    var checkinSummaryUseCase: CheckinSummaryUseCase { get set }
}

public class CheckinSummaryViewModel {
    private var dependencies: CheckinSummaryViewModelDependencies
    @Published var summary: CheckinSummaryViewConfiguration?

    public init(dependencies: CheckinSummaryViewModelDependencies) {
        self.dependencies = dependencies
    }

    public func save() async throws {
        try await dependencies.checkinSummaryUseCase.save()
    }

    public func refresh() {
        summary = dependencies.checkinSummaryUseCase.get().configuration()
    }
}

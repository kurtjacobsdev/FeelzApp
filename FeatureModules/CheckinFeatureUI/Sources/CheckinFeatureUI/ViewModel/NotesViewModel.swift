//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation
import CheckinFeatureDomain

public protocol NotesViewModelDependencies {
    var notesCaptureUseCase: NotesCaptureUseCase { get set }
}

public class NotesViewModel {
    private var dependencies: NotesViewModelDependencies

    public init(dependencies: NotesViewModelDependencies) {
        self.dependencies = dependencies
    }

    public func update(note: String) {
        dependencies.notesCaptureUseCase.store(note: note)
    }
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation

public protocol NotesCaptureUseCase {
    func store(note: String)
}

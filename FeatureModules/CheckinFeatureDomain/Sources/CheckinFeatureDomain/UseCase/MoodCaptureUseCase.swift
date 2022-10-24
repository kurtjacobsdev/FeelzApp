//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation

public protocol MoodCaptureUseCase {
    func store(mood: String)
}

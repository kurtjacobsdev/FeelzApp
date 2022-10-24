//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/21.
//

import Foundation

public protocol EntriesDetailUseCase {
    func get(identifier: String) -> Checkin?
    func delete(identifier: String) throws
}

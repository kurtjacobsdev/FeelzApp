//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation

public protocol CheckinWorker {
    func save(checkin: Checkin) throws
}

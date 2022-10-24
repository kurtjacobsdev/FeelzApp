//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import Foundation

public enum Mood: CaseIterable {
    case veryHappy
    case happy
    case content
    case sad
    case verySad

    public var tag: Int {
        switch self {
        case .veryHappy:
            return 1
        case .happy:
            return 2
        case .content:
            return 3
        case .sad:
            return 4
        case .verySad:
            return 5
        }
    }

    public var emoji: String {
        switch self {
        case .veryHappy:
            return "☺️"
        case .happy:
            return "🙂"
        case .content:
            return "😐"
        case .sad:
            return "🙁"
        case .verySad:
            return "☹️"
        }
    }

    public var title: String {
        switch self {
        case .veryHappy:
            return "Very Happy"
        case .happy:
            return "Happy"
        case .content:
            return "Content"
        case .sad:
            return "Sad"
        case .verySad:
            return "Very Sad"
        }
    }

    public static func mood(rawValue: String) -> Mood? {
        switch rawValue {
        case "Very Happy":
            return .veryHappy
        case "Happy":
            return .happy
        case "Content":
            return .content
        case "Sad":
            return .sad
        case "Very Sad":
            return .verySad
        default:
            return nil
        }
    }
}

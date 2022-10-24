//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import Foundation

public enum EntriesItem: Hashable {
    case checkin(EntriesListingCellConfiguration)
}

public enum EntriesSectionType {
    case checkin
}

public struct EntriesSection: Hashable, Identifiable {
    public let id: UUID = { return UUID() }()
    public let items: [EntriesItem]
    public let title: String?
    public let subtitle: String?
    public let type: EntriesSectionType

    public init(items: [EntriesItem],
                title: String? = nil,
                subtitle: String? = nil,
                type: EntriesSectionType) {
        self.items = items
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
}

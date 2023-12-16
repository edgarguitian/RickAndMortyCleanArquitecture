//
//  InfoResultData.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 16/12/23.
//

import Foundation
import SwiftData

@Model
class InfoResultData {
    @Attribute(.unique) let identifier: UUID
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    
    init(identifier: UUID = UUID(), count: Int, pages: Int, next: String?, prev: String?) {
        self.identifier = identifier
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}

//
//  InfoResultLocationsData.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation
import SwiftData

@Model
class InfoResultLocationsData {
    @Attribute(.unique) let currentPage: Int
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    var infoResultData: LocationsResultData

    init(currentPage: Int, count: Int, pages: Int, next: String?, prev: String?, infoResultData: LocationsResultData) {
        self.currentPage = currentPage
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
        self.infoResultData = infoResultData
    }
}

//
//  LocationsResultData.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation
import SwiftData

@Model
final class LocationsResultData {
    @Relationship(deleteRule: .cascade, inverse: \InfoResultLocationsData.infoResultData) let info: [InfoResultLocationsData]
    @Relationship(deleteRule: .cascade, inverse: \LocationsData.locationsResultData) var result: [LocationsData]
    @Attribute(.unique) let currentPage: Int

    init(info: [InfoResultLocationsData], result: [LocationsData] = [], currentPage: Int) {
        self.info = info
        self.result = result
        self.currentPage = currentPage
    }
}

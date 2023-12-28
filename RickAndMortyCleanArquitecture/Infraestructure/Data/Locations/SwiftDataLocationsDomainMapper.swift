//
//  SwiftDataLocationsDomainMapper.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class SwiftDataLocationsDomainMapper {
    func map(_ locationsList: [LocationsData], currentPage: Int) -> LocationResult {
        let result = locationsList.map {
            Location(id: $0.id, name: $0.name, type: $0.type,
                     dimension: $0.dimension, residents: [],
                     url: $0.url, created: $0.created)
        }
        if locationsList.isEmpty {
            return LocationResult(info: InfoResult(count: 0, pages: 0, next: "", prev: ""), result: result)
        } else {
            let lastLocation = locationsList[locationsList.count - 1]
            return LocationResult(info: InfoResult(count: lastLocation.page,
                                                   pages: lastLocation.numPages,
                                                   next: "",
                                                   prev: ""),
                                  result: result)
        }
    }
}

//
//  SwiftDataLocationsDomainMapper.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class SwiftDataLocationsDomainMapper {
    func map(_ locationsList: [LocationsResultData], currentPage: Int) -> LocationResult {
        if locationsList.count > currentPage && currentPage == -1 {
            return LocationResult(info: InfoResult(count: -1,
                                                    pages: -1,
                                                         next: nil,
                                                    prev: nil), result: [])
        } else {
            var locationResult: [Location] = []
            var lastPage = -1
            var pages = -1
            for location in locationsList {
                

                if location.info.count > 0 {
                    lastPage = location.info[location.info.count - 1].count
                    pages = location.info[location.info.count - 1].pages
                }
                let locationResultList = location.result.map {
                    Location(id: $0.id, name: $0.name, type: $0.type, dimension: $0.dimension, residents: $0.residents, url: $0.url, created: $0.created)
                }
                
                locationResult.append(contentsOf: locationResultList)

            }
            let locationResultSorted = locationResult.sorted(by: { $0.id < $1.id })
            return LocationResult(info: InfoResult(count: lastPage,
                                                    pages: pages,
                                                         next: nil,
                                                         prev: nil),
                                        result: locationResultSorted)
        }
        
    }
}

//
//  SwiftDataCacheLocationsDataSource.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class SwiftDataCacheLocationsDataSource: CacheLocationsDataSourceType {

    private let container: SwiftDataLocationsContainerType
    private let mapper: SwiftDataLocationsDomainMapper

    init(container: SwiftDataLocationsContainerType, mapper: SwiftDataLocationsDomainMapper) {
        self.container = container
        self.mapper = mapper
    }

    func getLocationsList(currentPage: Int) async -> LocationResult {
        let locationsList = await container.fetchLocations(page: currentPage)
        return mapper.map(locationsList, currentPage: currentPage)
    }

    func saveLocationsList(_ locationsList: LocationResult, currentPage: Int) async {

        for location in locationsList.result {
            let locationData = LocationsData(id: location.id,
                                             name: location.name,
                                             type: location.type,
                                             dimension: location.dimension,
                                             residents: [],
                                             url: location.url,
                                             created: location.created,
                                             page: currentPage,
                                             numPages: locationsList.info.pages,
                                             count: locationsList.info.count)

            await container.insert(locationsDataList: locationData)
        }

        if currentPage == locationsList.info.pages {
            await container.saveData()
        }

    }
}

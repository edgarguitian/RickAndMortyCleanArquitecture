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
        let locationsList = await container.fetchLocations()
        return mapper.map(locationsList, currentPage: currentPage)
    }

    func saveLocationsList(_ locationsList: LocationResult, currentPage: Int) async {
        let locationsResult = LocationsResultData(info: [], result: [], currentPage: currentPage)
        await container.insert(locationsResultList: locationsResult)

        let infoResultData = InfoResultLocationsData(currentPage: currentPage,
                                            count: locationsList.info.count,
                                            pages: locationsList.info.pages,
                                            next: locationsList.info.next,
                                            prev: locationsList.info.prev, infoResultData: locationsResult)
        await container.insert(infoResultList: infoResultData)

        for location in locationsList.result {
            let locationData = LocationsData(id: location.id, name: location.name, type: location.type,
                                             dimension: location.dimension, residents: location.residents,
                                             url: location.url, created: location.created,
                                             locationsResultData: locationsResult)

            await container.insert(locationsDataList: locationData)
        }

        if currentPage == locationsList.info.pages {
            await container.saveData()
        }

    }
}

//
//  AllLocationsListRepository.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class AllLocationsListRepository: AllLocationsListRepositoryType {

    private let apiDataSource: APILocationsDataSourceType
    private let errorMapper: RickAndMortyDomainErrorMapper
    private let cacheDataSource: CacheLocationsDataSourceType

    init(apiDataSource: APILocationsDataSourceType,
         errorMapper: RickAndMortyDomainErrorMapper,
         cacheDataSource: CacheLocationsDataSourceType) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.cacheDataSource = cacheDataSource
    }

    func getAllLocationsList(currentPage: Int) async -> Result<LocationResult, RickAndMortyDomainError> {
        /*let locationsListCache = await cacheDataSource.getLocationsList(currentPage: currentPage)

        if locationsListCache.info.pages > currentPage || currentPage == -1 {
            return .success(locationsListCache)
        }*/

        let locationsList = await apiDataSource.getLocationsList(currentPage: currentPage)

        guard case .success(let locationsListInfo) = locationsList else {
            return .failure(errorMapper.map(error: locationsList.failureValue as? HTTPClientError))
        }

        let locationsDomain = locationsListInfo.results.map {
            Location(id: $0.id, name: $0.name, type: $0.type,
                     dimension: $0.dimension, residents: $0.residents,
                     url: $0.url, created: $0.created)
        }

        let locationResultDomain = LocationResult(info:
                                                        InfoResult(count: locationsListInfo.info.count,
                                                                   pages: locationsListInfo.info.pages,
                                                                   next: locationsListInfo.info.next,
                                                                   prev: locationsListInfo.info.prev),
                                                     result: locationsDomain)

        //await cacheDataSource.saveLocationsList(locationResultDomain, currentPage: currentPage)

        return .success(locationResultDomain)
    }

}

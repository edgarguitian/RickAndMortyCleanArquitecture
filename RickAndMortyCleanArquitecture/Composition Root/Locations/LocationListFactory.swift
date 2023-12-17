//
//  LocationListFactory.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class LocationListFactory {
    
    static func create() -> LocationListView {
        return LocationListView(viewModel: createViewModel())
    }

    private static func createViewModel() -> LocationListViewModel {
        return LocationListViewModel(getLocationList: createGetAllLocationsListUseCase(),
                                     errorMapper: RickAndMortyPresentableErrorMapper())
    }

    private static func createGetAllLocationsListUseCase() -> GetAllLocationsList {
        return GetAllLocationsList(repository: createRepository())
    }
    

    private static func createRepository() -> AllLocationsListRepository {
        return AllLocationsListRepository(apiDataSource: createAPIDataSource(),
                                                 errorMapper: RickAndMortyDomainErrorMapper(),
                                                 cacheDataSource: createCacheDataSource())
    }

    static func createCacheDataSource() -> CacheCharacterDataSourceType {
        return SwiftDataCacheDataSource(container: SwiftDataContainer.shared, mapper: SwiftDataDomainMapper())
    }

    private static func createAPIDataSource() -> APILocationsDataSourceType {
        return APILocationsDataSource(httpClient: createHTTPClient())
    }

    private static func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
}

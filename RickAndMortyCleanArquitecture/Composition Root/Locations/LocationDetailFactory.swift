//
//  LocationDetailFactory.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class LocationDetailFactory: CreateLocationDetailView {
    func create(locationDetailInfo: LocationListPresentableItem) -> LocationDetailView {
        return LocationDetailView(viewModel: createViewModel(locationDetailInfo: locationDetailInfo))
    }
    
    private func createViewModel(locationDetailInfo: LocationListPresentableItem) -> LocationDetailViewModel {
        return LocationDetailViewModel(getSingleCharacter: createUseCase(), locationDetailInfo: locationDetailInfo, errorMapper: RickAndMortyPresentableErrorMapper())
    }
    
    private func createUseCase() -> GetSingleCharacter {
        return GetSingleCharacter(repository: createRepository())
    }
    
    private func createRepository() -> SingleCharacterRepositoryType {
        return SingleCharacterRepository(apiDataSource: createAPIDataSource(), errorMapper: RickAndMortyDomainErrorMapper(), cacheDataSource: CharacterDetailFactory.createCacheDataSource())
    }
    
    static func createCacheDataSource() -> CacheCharacterDataSourceType {
        return SwiftDataCacheCharactersDataSource(container: SwiftDataCharactersContainer.shared, mapper: SwiftDataCharactersDomainMapper())
    }
    
    private func createAPIDataSource() -> APISingleCharacterDataSourceType {
        return APISingleCharacterDataSource(httpClient: LocationDetailFactory.createHTTPClient())
    }
    
    private static func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
}

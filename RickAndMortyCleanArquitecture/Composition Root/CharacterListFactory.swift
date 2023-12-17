//
//  CharacterListFactory.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

class CharacterListFactory {
    static func create() -> CharacterListView {
        return CharacterListView(viewModel: createViewModel(), createCharacterDetailView: CharacterDetailFactory())
    }

    private static func createViewModel() -> CharacterListViewModel {
        return CharacterListViewModel(getCharacterList: createGetAllCharactersListUseCase(),
                                   errorMapper: RickAndMortyPresentableErrorMapper())
    }

    private static func createGetAllCharactersListUseCase() -> GetAllCharactersList {
        return GetAllCharactersList(repository: createRepository())
    }

    private static func createRepository() -> AllCharactersListRepository {
        return AllCharactersListRepository(apiDataSource: createAPIDataSource(),
                                                 errorMapper: RickAndMortyDomainErrorMapper(),
                                                 cacheDataSource: createCacheDataSource())
    }

    static func createCacheDataSource() -> CacheCharacterDataSourceType {
        return SwiftDataCacheDataSource(container: SwiftDataContainer.shared, mapper: SwiftDataDomainMapper())
    }

    private static func createAPIDataSource() -> APICharactersDataSourceType {
        return APICharactersDataSource(httpClient: createHTTPClient())
    }

    private static func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
}

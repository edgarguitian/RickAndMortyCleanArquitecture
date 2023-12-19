//
//  CharacterDetailFactory.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class CharacterDetailFactory: CreateCharacterDetailView {
    func create(characterId: String) -> CharacterDetailView {
        return CharacterDetailView(viewModel: createViewModel(characterId: characterId))
    }
    
    func createViewModel(characterId: String) -> CharacterDetailViewModel {
        return CharacterDetailViewModel(getSingleCharacter: createUseCase(), errorMapper: RickAndMortyPresentableErrorMapper(), characterId: characterId)
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
        return APISingleCharacterDataSource(httpClient: CharacterDetailFactory.createHTTPClient())
    }
    
    private static func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
    
    
}

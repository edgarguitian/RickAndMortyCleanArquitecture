//
//  EpisodeDetailFactory.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class EpisodeDetailFactory: CreateEpisodeDetailView {
    func create(episodeDetailInfo: EpisodeListPresentableItem) -> EpisodeDetailView {
        return EpisodeDetailView(viewModel: createViewModel(episodeDetailInfo: episodeDetailInfo), createCharacterDetailView: CharacterDetailFactory())
    }
    
    private func createViewModel(episodeDetailInfo: EpisodeListPresentableItem) -> EpisodeDetailViewModel {
        return EpisodeDetailViewModel(episodeDetailInfo: episodeDetailInfo, getSingleCharacter: createUseCase(), errorMapper: RickAndMortyPresentableErrorMapper())
    }
    
    private func createUseCase() -> GetSingleCharacter {
        return GetSingleCharacter(repository: createRepository())
    }
    
    private func createRepository() -> SingleCharacterRepositoryType {
        return SingleCharacterRepository(apiDataSource: createAPIDataSource(), errorMapper: RickAndMortyDomainErrorMapper(), cacheDataSource: EpisodeDetailFactory.createCacheDataSource())
    }
    
    static func createCacheDataSource() -> CacheCharacterDataSourceType {
        return SwiftDataCacheCharactersDataSource(container: SwiftDataCharactersContainer.shared, mapper: SwiftDataCharactersDomainMapper())
    }
    
    private func createAPIDataSource() -> APISingleCharacterDataSourceType {
        return APISingleCharacterDataSource(httpClient: EpisodeDetailFactory.createHTTPClient())
    }
    
    private static func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
    
}

//
//  CharacterDetailFactory.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class CharacterDetailFactory: CreateCharacterDetailView {
    func create(characterId: String) -> CharacterDetailView {
        return CharacterDetailView(viewModel: createViewModel(characterId: characterId),
                                   createEpisodeDetailView: EpisodeDetailFactory())
    }

    func createViewModel(characterId: String) -> CharacterDetailViewModel {
        return CharacterDetailViewModel(getSingleCharacter: createUseCase(),
                                        getSingleEpisode: createSingleEpisodeUseCase(),
                                        errorMapper: RickAndMortyPresentableErrorMapper(),
                                        characterId: characterId)
    }

    private func createUseCase() -> GetSingleCharacter {
        return GetSingleCharacter(repository: createRepository())
    }

    private func createSingleEpisodeUseCase() -> GetSingleEpisode {
        return GetSingleEpisode(repository: createEpisodeRepository())
    }

    private func createRepository() -> SingleCharacterRepositoryType {
        return SingleCharacterRepository(apiDataSource: createAPIDataSource(),
                                         errorMapper: RickAndMortyDomainErrorMapper(),
                                         cacheDataSource: CharacterDetailFactory.createCacheDataSource())
    }

    private func createEpisodeRepository() -> SingleEpisodeRepositoryType {
        return SingleEpisodeRepository(apiDataSource: createAPIEpisodeDataSource(),
                                       errorMapper: RickAndMortyDomainErrorMapper(),
                                       cacheDataSource: CharacterDetailFactory.createCacheEpisodeDataSource())
    }

    static func createCacheDataSource() -> CacheCharacterDataSourceType {
        return SwiftDataCacheCharactersDataSource(container: SwiftDataCharactersContainer.shared,
                                                  mapper: SwiftDataCharactersDomainMapper())
    }

    static func createCacheEpisodeDataSource() -> CacheEpisodesDataSourceType {
        return SwiftDataCacheEpisodesDataSource(container: SwiftDataEpisodesContainer.shared,
                                                mapper: SwiftDataEpisodesDomainMapper())
    }

    private func createAPIDataSource() -> APISingleCharacterDataSourceType {
        return APISingleCharacterDataSource(httpClient: CharacterDetailFactory.createHTTPClient())
    }

    private func createAPIEpisodeDataSource() -> APISingleEpisodeDataSourceType {
        return APISingleEpisodeDataSource(httpClient: CharacterDetailFactory.createHTTPClient())
    }

    private static func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }

}

//
//  AllEpisodesListRepository.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class AllEpisodesListRepository: AllEpisodesListRepositoryType {
    
    private let apiDataSource: APIEpisodesDataSourceType
    private let errorMapper: RickAndMortyDomainErrorMapper
    private let cacheDataSource: CacheCharacterDataSourceType
    
    init(apiDataSource: APIEpisodesDataSourceType, errorMapper: RickAndMortyDomainErrorMapper, cacheDataSource: CacheCharacterDataSourceType) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.cacheDataSource = cacheDataSource
    }
    
    func getAllEpisodesList(currentPage: Int) async -> Result<EpisodeResult, RickAndMortyDomainError> {
        /*let charactersListCache = await cacheDataSource.getCharactersList(currentPage: currentPage)
        
        if charactersListCache.info.pages > currentPage || currentPage == -1 {
            return .success(charactersListCache)
        }*/
        
        let episodesList = await apiDataSource.getEpisodesList(currentPage: currentPage)
        
        guard case .success(let episodesListInfo) = episodesList else {
            return .failure(errorMapper.map(error: episodesList.failureValue as? HTTPClientError))
        }
        
        let episodesDomain = episodesListInfo.results.map {
            Episode(id: $0.id, name: $0.name, air_date: $0.air_date, episode: $0.episode, characters: $0.characters, url: $0.url, created: $0.created)
        }
        
        let episodesResultDomain = EpisodeResult(info:
                                                        InfoResult(count: episodesListInfo.info.count,
                                                                   pages: episodesListInfo.info.pages,
                                                                   next: episodesListInfo.info.next,
                                                                   prev: episodesListInfo.info.prev),
                                                     result: episodesDomain)
        
        //await cacheDataSource.saveCharactersList(charactersResultDomain, currentPage: currentPage)
        
        return .success(episodesResultDomain)
    }
    
}

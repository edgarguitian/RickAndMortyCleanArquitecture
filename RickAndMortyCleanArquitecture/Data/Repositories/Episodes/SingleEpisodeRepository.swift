//
//  SingleEpisodeRepository.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 20/12/23.
//

import Foundation

class SingleEpisodeRepository: SingleEpisodeRepositoryType {
    
    
    private let apiDataSource: APISingleEpisodeDataSourceType
    private let errorMapper: RickAndMortyDomainErrorMapper
    private let cacheDataSource: CacheEpisodesDataSourceType
    
    init(apiDataSource: APISingleEpisodeDataSourceType, errorMapper: RickAndMortyDomainErrorMapper, cacheDataSource: CacheEpisodesDataSourceType) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.cacheDataSource = cacheDataSource
    }

    func getSingleEpisode(url: URL) async -> Result<Episode, RickAndMortyDomainError> {
        let episodeResponse = await apiDataSource.getSingleEpisode(url: url)
        
        guard case .success(let episodeResponseInfo) = episodeResponse else {
            return .failure(errorMapper.map(error: episodeResponse.failureValue as? HTTPClientError))
        }
        
        let episodeDomain = Episode(id: episodeResponseInfo.id,
                                    name: episodeResponseInfo.name,
                                    air_date: episodeResponseInfo.air_date,
                                    episode: episodeResponseInfo.episode,
                                    characters: episodeResponseInfo.characters,
                                    url: episodeResponseInfo.url,
                                    created: episodeResponseInfo.created)

        return .success(episodeDomain)
    }
    
}

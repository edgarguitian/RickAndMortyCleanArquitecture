//
//  SwiftDataCacheEpisodesDataSource.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class SwiftDataCacheEpisodesDataSource: CacheEpisodesDataSourceType {

    private let container: SwiftDataEpisodesContainerType
    private let mapper: SwiftDataEpisodesDomainMapper
    
    init(container: SwiftDataEpisodesContainerType, mapper: SwiftDataEpisodesDomainMapper) {
        self.container = container
        self.mapper = mapper
    }

    func getEpisodesList(currentPage: Int) async -> EpisodeResult {
        let charactersList = await container.fetchEpisodes()
        return mapper.map(charactersList, currentPage: currentPage)
    }
    
    func saveEpisodesList(_ episodesList: EpisodeResult, currentPage: Int) async {
        let episodesResult = EpisodesResultData(info: [], result: [], currentPage: currentPage)
        await container.insert(episodesResultList: episodesResult)
        
        let infoResultData = InfoResultEpisodesData(currentPage: currentPage,
                                            count: episodesList.info.count,
                                            pages: episodesList.info.pages,
                                            next: episodesList.info.next,
                                            prev: episodesList.info.prev, infoResultData: episodesResult)
        await container.insert(infoResultList: infoResultData)
        
        for episode in episodesList.result {
            let episodeData = EpisodesData(id: episode.id, name: episode.name, air_date: episode.air_date, episode: episode.episode, characters: episode.characters, url: episode.url, created: episode.created, episodesResultData: episodesResult)
            
            await container.insert(episodesDataList: episodeData)
        }
        
        if currentPage == episodesList.info.pages {
            await container.saveData()
        }
        
    }
}

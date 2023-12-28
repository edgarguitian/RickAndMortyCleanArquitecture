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
        let charactersList = await container.fetchEpisodes(page: currentPage)
        return mapper.map(charactersList, currentPage: currentPage)
    }

    func saveEpisodesList(_ episodesList: EpisodeResult, currentPage: Int) async {

        for episode in episodesList.result {
            let episodeData = EpisodesData(id: episode.id,
                                           name: episode.name,
                                           airDate: episode.airDate,
                                           episode: episode.episode,
                                           url: episode.url,
                                           created: episode.created,
                                           page: currentPage,
                                           numPages: episodesList.info.pages,
                                           count: episodesList.info.count)
            await container.insert(episodesDataList: episodeData)
        }

        if currentPage == episodesList.info.pages {
            await container.saveData()
        }

    }
}

//
//  SwiftDataEpisodesDomainMapper.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class SwiftDataEpisodesDomainMapper {
    func map(_ episodesList: [EpisodesResultData], currentPage: Int) -> EpisodeResult {
        if episodesList.count > currentPage && currentPage == -1 {
            return EpisodeResult(info: InfoResult(count: -1,
                                                    pages: -1,
                                                         next: nil,
                                                    prev: nil), result: [])
        } else {
            var episodeResult: [Episode] = []
            var lastPage = -1
            var pages = -1
            for episode in episodesList {
                

                if episode.info.count > 0 {
                    lastPage = episode.info[episode.info.count - 1].count

                    pages = episode.info[episode.info.count - 1].pages
                }
                let episodeResultList = episode.result.map {
                    Episode(id: $0.id, name: $0.name, air_date: $0.air_date, episode: $0.episode, characters: $0.characters, url: $0.url, created: $0.created)
                }
                
                episodeResult.append(contentsOf: episodeResultList)

            }
            let episodeResultSorted = episodeResult.sorted(by: { $0.id < $1.id })
            return EpisodeResult(info: InfoResult(count: lastPage,
                                                    pages: pages,
                                                         next: nil,
                                                         prev: nil),
                                        result: episodeResultSorted)
        }
        
    }
}

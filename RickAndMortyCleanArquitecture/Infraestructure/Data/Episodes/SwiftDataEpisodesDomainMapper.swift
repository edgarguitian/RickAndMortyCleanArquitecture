//
//  SwiftDataEpisodesDomainMapper.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class SwiftDataEpisodesDomainMapper {
    func map(_ episodesList: [EpisodesData], currentPage: Int) -> EpisodeResult {
        let result = episodesList.map {
            Episode(id: $0.id, name: $0.name, airDate: $0.airDate,
                    episode: $0.episode, characters: [],
                    url: $0.url, created: $0.created)
        }
        if episodesList.isEmpty {
            return EpisodeResult(info: InfoResult(count: 0, pages: 0, next: "", prev: ""), result: result)
        } else {
            let lastEpisode = episodesList[episodesList.count - 1]
            return EpisodeResult(info: InfoResult(count: lastEpisode.page,
                                                  pages: lastEpisode.numPages,
                                                  next: "",
                                                  prev: ""),
                                 result: result)
        }

    }
}

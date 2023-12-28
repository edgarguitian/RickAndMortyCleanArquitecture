//
//  CacheEpisodesDataSourceType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

protocol CacheEpisodesDataSourceType {
    func getEpisodesList(currentPage: Int) async -> EpisodeResult
    func saveEpisodesList(_ episodesList: EpisodeResult, currentPage: Int) async
}

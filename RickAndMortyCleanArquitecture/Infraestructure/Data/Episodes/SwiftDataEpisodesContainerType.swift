//
//  SwiftDataEpisodesContainerType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

protocol SwiftDataEpisodesContainerType {
    func fetchEpisodes() async -> [EpisodesData]
    func fetchEpisodes(page: Int) -> [EpisodesData]
    func insert(episodesDataList: EpisodesData) async
    func saveData() async
}

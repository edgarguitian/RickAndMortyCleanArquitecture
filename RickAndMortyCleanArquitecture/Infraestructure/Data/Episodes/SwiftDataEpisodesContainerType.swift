//
//  SwiftDataEpisodesContainerType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

protocol SwiftDataEpisodesContainerType {
    func fetchEpisodes() async -> [EpisodesResultData]
    func insert(episodesResultList: EpisodesResultData) async
    func insert(episodesDataList: EpisodesData) async
    func insert(infoResultList: InfoResultEpisodesData) async
    func saveData() async
}

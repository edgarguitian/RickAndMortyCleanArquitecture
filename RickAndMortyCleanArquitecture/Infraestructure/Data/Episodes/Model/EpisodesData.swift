//
//  EpisodesData.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation
import SwiftData

@Model
class EpisodesData {
    @Attribute(.unique) let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    var episodesResultData: EpisodesResultData


    init(id: Int, name: String, airDate: String, episode: String, characters: [String], url: String, created: String, episodesResultData: EpisodesResultData) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episode = episode
        self.characters = characters
        self.url = url
        self.created = created
        self.episodesResultData = episodesResultData
    }
}

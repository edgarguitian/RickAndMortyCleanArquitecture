//
//  EpisodeListPresentableItem.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

struct EpisodeListPresentableItem {
    let id: String
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String

    init(id: String, name: String, airDate: String,
         episode: String, characters: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episode = episode
        self.characters = characters
        self.url = url
        self.created = DateFormatterUtils.formatDate(created)
    }
}

extension EpisodeListPresentableItem: Hashable {

}

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
    let url: String
    let created: String
    let page: Int
    let numPages: Int
    let count: Int

    init(id: Int, name: String, airDate: String, episode: String, url: String, created: String, page: Int, numPages: Int, count: Int) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episode = episode
        self.url = url
        self.created = created
        self.page = page
        self.numPages = numPages
        self.count = count
    }
}

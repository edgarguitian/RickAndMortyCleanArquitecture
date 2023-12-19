//
//  EpisodesResultData.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation
import SwiftData

@Model
final class EpisodesResultData {
    @Relationship(deleteRule: .cascade, inverse: \InfoResultEpisodesData.infoResultData) let info: [InfoResultEpisodesData]
    @Relationship(deleteRule: .cascade, inverse: \EpisodesData.episodesResultData) var result: [EpisodesData]
    @Attribute(.unique) let currentPage: Int

    init(info: [InfoResultEpisodesData], result: [EpisodesData] = [], currentPage: Int) {
        self.info = info
        self.result = result
        self.currentPage = currentPage
    }
}

//
//  EpisodeResponseDTO.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

struct EpisodeResponseDTO: Codable {
    let info: InfoDTO
    let results: [EpisodeListDTO]

    enum CodingKeys: String, CodingKey {
        case info, results
    }
}

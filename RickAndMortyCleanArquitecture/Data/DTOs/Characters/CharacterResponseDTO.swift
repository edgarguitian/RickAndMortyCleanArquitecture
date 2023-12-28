//
//  CharacterResponseDTO.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

struct CharacterResponseDTO: Codable {
    let info: InfoDTO
    let results: [CharacterListDTO]

    enum CodingKeys: String, CodingKey {
        case info, results
    }
}

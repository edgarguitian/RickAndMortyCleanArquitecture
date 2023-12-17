//
//  LocationCharacterDTO.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

struct LocationCharacterDTO: Codable {
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, url
    }
}

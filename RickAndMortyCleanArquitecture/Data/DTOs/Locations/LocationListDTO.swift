//
//  LocationListDTO.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

struct LocationListDTO: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name, type, dimension, residents, url, created
    }
}

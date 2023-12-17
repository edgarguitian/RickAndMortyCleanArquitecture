//
//  LocationResponseDTO.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

struct LocationResponseDTO: Codable {
    let info: InfoDTO
    let results: [LocationListDTO]

    enum CodingKeys: String, CodingKey {
        case info, results
    }
}

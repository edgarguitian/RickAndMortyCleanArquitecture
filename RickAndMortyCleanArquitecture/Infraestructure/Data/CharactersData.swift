//
//  CharactersData.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation
import SwiftData

@Model
class CharactersData {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationData
    let location: LocationData
    let image: String
    let episode: [String]
    let url: String
    let created: String

    init(id: Int, name: String, status: String, species: String,
         type: String, gender: String, origin: LocationData, location: LocationData,
         image: String, episode: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

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
    @Attribute(.unique) let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let url: String
    let created: String
    let page: Int
    let numPages: Int
    let count: Int

    init(id: Int, name: String, status: String, species: String, type: String, gender: String, image: String, url: String, created: String, page: Int, numPages: Int, count: Int) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.image = image
        self.url = url
        self.created = created
        self.page = page
        self.numPages = numPages
        self.count = count
    }
}

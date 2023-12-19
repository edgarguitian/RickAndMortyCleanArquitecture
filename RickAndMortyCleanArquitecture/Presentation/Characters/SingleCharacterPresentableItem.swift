//
//  SingleCharacterPresentableItem.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

struct SingleCharacterPresentableItem {
    let id: String
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationCharacter
    let location: LocationCharacter
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    
    init() {
        self.id = ""
        self.name = ""
        self.status = ""
        self.species = ""
        self.type = ""
        self.gender = ""
        self.origin = LocationCharacter(name: "", url: "")
        self.location = LocationCharacter(name: "", url: "")
        self.image = ""
        self.episode = []
        self.url = ""
        self.created = ""
    }
    
    init(id: String, name: String, status: String, species: String, type: String, gender: String, origin: LocationCharacter, location: LocationCharacter, image: String, episode: [String], url: String, created: String) {
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
    
    init(character: Character) {
        self.id = String(character.id)
        self.name = character.name
        self.status = character.status
        self.species = character.species
        self.type = character.type
        self.gender = character.gender
        self.origin = character.origin
        self.location = character.location
        self.image = character.image
        self.episode = character.episode
        self.url = character.url
        self.created = DateFormatterUtils.formatDate(character.created)
    }
    
    
}

extension SingleCharacterPresentableItem: Hashable {
    static func == (lhs: SingleCharacterPresentableItem, rhs: SingleCharacterPresentableItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    
    
}

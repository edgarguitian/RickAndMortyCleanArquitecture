//
//  LocationData.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation
import SwiftData

@Model
class LocationCharacterData {
    @Attribute(.unique) let id: UUID
    let name: String
    let url: String
    var charactersData: CharactersData
    
    init(id: UUID = UUID(), name: String, url: String, charactersData: CharactersData) {
        self.id = id
        self.name = name
        self.url = url
        self.charactersData = charactersData
    }
}

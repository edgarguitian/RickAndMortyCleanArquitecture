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
    let origin: Location
    let location: Location
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
        self.origin = Location(name: "", url: "")
        self.location = Location(name: "", url: "")
        self.image = ""
        self.episode = []
        self.url = ""
        self.created = ""
    }
    
    init(id: String, name: String, status: String, species: String, type: String, gender: String, origin: Location, location: Location, image: String, episode: [String], url: String, created: String) {
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
        self.created = Self.formatDate(character.created)
    }
    
    
}

extension SingleCharacterPresentableItem: Hashable {
    static func == (lhs: SingleCharacterPresentableItem, rhs: SingleCharacterPresentableItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    static func convertStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return dateFormatter.date(from: dateString)
    }
    
    static func convertDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current 
        
        return dateFormatter.string(from: date)
    }
    
    static func formatDate(_ dateString: String) -> String {
        let dateCreated = convertStringToDate(dateString)
        guard let dateCreatedClean = dateCreated else {
            return dateString
        }
        
        let dateCreatedDescription = convertDateToString(dateCreatedClean)
        return dateCreatedDescription
    }
    
}

//
//  SwiftDataCharactersDomainMapper.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 16/12/23.
//

import Foundation

class SwiftDataCharactersDomainMapper {
    func map(_ charactersList: [CharactersData], currentPage: Int) -> CharacterResult {
        let result = charactersList.map {
            Character(id: $0.id, name: $0.name, status: $0.status,
                      species: $0.species, type: $0.type, gender: $0.gender,
                      origin: LocationCharacter(name: "", url: ""),
                      location: LocationCharacter(name: "", url: ""),
                      image: $0.image, episode: [], url: $0.url, created: $0.created)
        }
        if charactersList.isEmpty {
            return CharacterResult(info: InfoResult(count: 0, pages: 0, next: "", prev: ""), result: result)
        } else {
            let lastCharacter = charactersList[charactersList.count - 1]
            return CharacterResult(info: InfoResult(count: lastCharacter.page, pages: lastCharacter.numPages, next: "", prev: ""), result: result)
        }
    }
}

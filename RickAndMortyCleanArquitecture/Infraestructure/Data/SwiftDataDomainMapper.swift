//
//  SwiftDataDomainMapper.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 16/12/23.
//

import Foundation

class SwiftDataDomainMapper {
    func map(_ charactersList: [CharactersResultData], currentPage: Int) -> CharacterResult {
        if charactersList.count > currentPage && currentPage == -1 {
            return CharacterResult(info: InfoResult(count: -1,
                                                    pages: -1,
                                                         next: nil,
                                                    prev: nil), result: [])
        } else {
            var characterResult: [Character] = []
            var lastPage = -1
            var pages = -1
            for character in charactersList {
                

                lastPage = character.currentPage
                if character.info.count > 0 {
                    pages = character.info[character.info.count - 1].pages
                }
                let characterResultList = character.result.map {
                    Character(id: $0.id, name: $0.name, status: $0.status, species: $0.species,
                              type: $0.type, gender: $0.gender, origin: LocationCharacter(name: $0.origin?.name ?? "", url: $0.origin?.url ?? ""),
                              location: LocationCharacter(name: "", url: ""), image: $0.image,
                              episode: $0.episode, url: $0.url, created: $0.created)
                }
                
                characterResult.append(contentsOf: characterResultList)

            }
            let characterResultSorted = characterResult.sorted(by: { $0.id < $1.id })
            return CharacterResult(info: InfoResult(count: lastPage,
                                                    pages: pages,
                                                         next: nil,
                                                         prev: nil),
                                        result: characterResultSorted)
        }
    }
}

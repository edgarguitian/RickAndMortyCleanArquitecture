//
//  SwiftDataDomainMapper.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 16/12/23.
//

import Foundation

class SwiftDataDomainMapper {
    func map(_ charactersList: [CharactersResultData], currentPage: Int) -> CharacterResult {
        if charactersList.count > currentPage && currentPage > -1 {
            return CharacterResult(info: InfoResult(count: -1,
                                                    pages: -1,
                                                         next: nil,
                                                    prev: nil), result: [])
        } else {
            print("CharactersListCount: \(charactersList.count)")
            print("CurrentPage: \(currentPage)")
            var characterResult: [Character] = []
            for character in charactersList {
                for i in 0..<character.result.count { // TODO: fuera
                    if character.result[i].origin == nil {
                        print(i)
                    }
                    
                    if character.result[i].location == nil {
                        print(i)
                    }
                    
                    if character.result[i] == nil {
                        print(i)
                    }
                }
                let characterResultList = character.result.map {
                    Character(id: $0.id, name: $0.name, status: $0.status, species: $0.species,
                              type: $0.type, gender: $0.gender, origin: LocationCharacter(name: $0.origin?.name ?? "", url: $0.origin?.url ?? ""),
                              location: LocationCharacter(name: $0.location?.name ?? "", url: $0.location?.url ?? ""), image: $0.image,
                              episode: $0.episode, url: $0.url, created: $0.created)
                }
                
                characterResult.append(contentsOf: characterResultList)
            }
            let characterResultSorted = characterResult.sorted(by: { $0.id < $1.id })
            return CharacterResult(info: InfoResult(count: characterResult.count,
                                                    pages: charactersList.count,
                                                         next: nil,
                                                         prev: nil),
                                        result: characterResultSorted)
        }
        
        
        
    }
    
    func map(_ charactersList: CharacterResult, currentPage: Int) -> CharactersResultData {
        let characterResultList = charactersList.result.map {
            CharactersData(id: $0.id, name: $0.name, status: $0.status, species: $0.species,
                           type: $0.type, gender: $0.gender, origin: LocationData(name: $0.origin.name, url: $0.origin.url),
                           location: LocationData(name: $0.location.name, url: $0.location.url), image: $0.image,
                           episode: $0.episode, url: $0.url, created: $0.created)
        }
        return CharactersResultData(info:
                                        InfoResultData(count: charactersList.info.count,
                                                       pages: charactersList.info.pages,
                                                       next: charactersList.info.next,
                                                       prev: charactersList.info.prev),
                                    result: characterResultList,
                                    currentPage: currentPage)
        
    }
}

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
            print("--> CharactersListCount: \(charactersList.count)")
            print("--> CurrentPage: \(currentPage)")
            var characterResult: [Character] = []
            var lastPage = currentPage
            for character in charactersList {
                print("Procesando character \(character.id)")
                print("CharacterList Current Page \(character.currentPage)")
                lastPage = character.currentPage
                let characterResultList = character.result.map {
                    Character(id: $0.id, name: $0.name, status: $0.status, species: $0.species,
                              type: $0.type, gender: $0.gender, origin: LocationCharacter(name: $0.origin?.name ?? "", url: $0.origin?.url ?? ""),
                              location: LocationCharacter(name: "", url: ""), image: $0.image,
                              episode: $0.episode, url: $0.url, created: $0.created)
                }
                
                characterResult.append(contentsOf: characterResultList)
                print("--> characterResultList Count \(characterResultList.count)")

            }
            print("--> characterResult Count \(characterResult.count)")
            let characterResultSorted = characterResult.sorted(by: { $0.id < $1.id })
            print("--> characterResultSorted Count \(characterResultSorted.count)")
            return CharacterResult(info: InfoResult(count: characterResult.count,
                                                    pages: lastPage,
                                                         next: nil,
                                                         prev: nil),
                                        result: characterResultSorted)
        }
        /*var characterResult: [CharacterResult] = []
        for characterResultData in charactersList {
            if let info = characterResultData.info {
                let characterResultItem = CharacterResult(info: InfoResult(count: info.count,
                                                                           pages: info.pages,
                                                                           next: info.next,
                                                                           prev: info.prev),
                                                               result: [])
                characterResult.append(characterResultItem)
            } else {
                characterResult.append(CharacterResult(info: InfoResult(count: -1,
                                                                        pages: charactersList.count,
                                                                        next: nil,
                                                                        prev: nil),
                                                            result: []))
            }
            
        }
        return characterResult*/
        
        
    }
}

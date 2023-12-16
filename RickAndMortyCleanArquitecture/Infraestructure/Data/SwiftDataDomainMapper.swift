//
//  SwiftDataDomainMapper.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 16/12/23.
//

import Foundation

class SwiftDataDomainMapper {
    func map(_ charactersList: CharactersResultData, currentPage: Int) -> CharacterResult {
        let characterResultList = charactersList.result.map {
            Character(id: $0.id, name: $0.name, status: $0.status, species: $0.species,
                      type: $0.type, gender: $0.gender, origin: Location(name: $0.origin.name, url: $0.origin.url),
                      location: Location(name: $0.location.name, url: $0.location.url), image: $0.image,
                      episode: $0.episode, url: $0.url, created: $0.created)
        }
        guard let characterInfo = charactersList.info else {
            return CharacterResult(info: InfoResult(count: -1,
                                                    pages: -1,
                                                    next: "",
                                                    prev: ""),
                                   result: characterResultList)
        }
        return CharacterResult(info: InfoResult(count: characterInfo.count,
                                             pages: characterInfo.pages,
                                             next: characterInfo.next,
                                             prev: characterInfo.prev),
                            result: characterResultList)
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

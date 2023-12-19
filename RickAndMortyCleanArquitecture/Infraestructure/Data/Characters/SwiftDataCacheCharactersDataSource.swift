//
//  SwiftDataCacheCharactersDataSource.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

class SwiftDataCacheCharactersDataSource: CacheCharacterDataSourceType {

    private let container: SwiftDataCharactersContainerType
    private let mapper: SwiftDataCharactersDomainMapper
    
    init(container: SwiftDataCharactersContainerType, mapper: SwiftDataCharactersDomainMapper) {
        self.container = container
        self.mapper = mapper
    }

    func getCharactersList(currentPage: Int) async -> CharacterResult {
        let charactersList = await container.fetchCharacters()
        return mapper.map(charactersList, currentPage: currentPage)
    }
    
    func saveCharactersList(_ charactersList: CharacterResult, currentPage: Int) async {
        
        let charactersResult = CharactersResultData(info: [], result: [], currentPage: currentPage)
        await container.insert(charactersResultList: charactersResult)
        
        let infoResultData = InfoResultCharactersData(currentPage: currentPage,
                                            count: charactersList.info.count,
                                            pages: charactersList.info.pages,
                                            next: charactersList.info.next,
                                            prev: charactersList.info.prev, infoResultData: charactersResult)
        await container.insert(infoResultList: infoResultData)
        
        for character in charactersList.result {
            
            
            let characterData = CharactersData(id: character.id, name: character.name, status: character.status, species: character.species,
                                               type: character.type, gender: character.gender, origin: nil,
                                               location: nil, image: character.image,
                                               episode: character.episode, url: character.url, created: character.created, charactersResultData: charactersResult)
            await container.insert(charactersDataList: characterData)
            let locationOrigin = LocationCharacterData(name: character.origin.name, url: character.origin.url, charactersData: characterData)
            let locationLocation = LocationCharacterData(name: character.location.name, url: character.location.url, charactersData: characterData)
            await container.insert(locationList: locationOrigin)
            await container.insert(locationList: locationLocation)
        }
        
        if currentPage == charactersList.info.pages {
            await container.saveData()
        }
        
    }
}


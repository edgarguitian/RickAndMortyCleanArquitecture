//
//  SwiftDataCacheDataSource.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

class SwiftDataCacheDataSource: CacheCharacterDataSourceType {

    private let container: SwiftDataContainerType
    private let mapper: SwiftDataDomainMapper
    
    init(container: SwiftDataContainerType, mapper: SwiftDataDomainMapper) {
        self.container = container
        self.mapper = mapper
    }

    func getCharactersList(currentPage: Int) async -> CharacterResult {
        let charactersList = await container.fetchCharacters()
        return mapper.map(charactersList, currentPage: currentPage)
    }
    
    func saveCharactersList(_ charactersList: CharacterResult, currentPage: Int) async {
        /*
        let infoResultData = InfoResultData(count: charactersList.info.count,
                                            pages: charactersList.info.pages,
                                            next: charactersList.info.next,
                                            prev: charactersList.info.prev, infoResultData: [])
        await container.insert(infoResultList: infoResultData)
        
        var charactersDataResult: [CharactersData] = []
        for character in charactersList.result {
            let locationOrigin = LocationData(name: character.origin.name, url: character.origin.url, charactersData: [])
            let locationLocation = LocationData(name: character.location.name, url: character.location.url, charactersData: [])
            await container.insert(locationList: locationOrigin)
            await container.insert(locationList: locationLocation)
            
            let characterData = CharactersData(id: character.id, name: character.name, status: character.status, species: character.species,
                                               type: character.type, gender: character.gender, origin: locationOrigin,
                                               location: locationLocation, image: character.image,
                                               episode: character.episode, url: character.url, created: character.created, charactersResultData: [])
            await container.insert(charactersDataList: characterData)
            charactersDataResult.append(characterData)
        }
        
        let charactersResult = CharactersResultData(info: infoResultData, result: charactersDataResult, currentPage: currentPage)
        await container.insert(charactersResultList: charactersResult)
        */
        
        let charactersResult = CharactersResultData(info: nil, result: [], currentPage: currentPage)
        await container.insert(charactersResultList: charactersResult)
        
        let infoResultData = InfoResultData(count: charactersList.info.count,
                                            pages: charactersList.info.pages,
                                            next: charactersList.info.next,
                                            prev: charactersList.info.prev, infoResultData: charactersResult)
        await container.insert(infoResultList: infoResultData)
        
        //var charactersDataResult: [CharactersData] = []
        for character in charactersList.result {
            
            
            let characterData = CharactersData(id: character.id, name: character.name, status: character.status, species: character.species,
                                               type: character.type, gender: character.gender, origin: nil,
                                               location: nil, image: character.image,
                                               episode: character.episode, url: character.url, created: character.created, charactersResultData: charactersResult)
            await container.insert(charactersDataList: characterData)
            //charactersDataResult.append(characterData)
            //print(character.origin.name)
            let locationOrigin = LocationData(name: character.origin.name, url: character.origin.url, charactersData: characterData)
            let locationLocation = LocationData(name: character.location.name, url: character.location.url, charactersData: characterData)
            await container.insert(locationList: locationOrigin)
            await container.insert(locationList: locationLocation)
        }
        
    }
}

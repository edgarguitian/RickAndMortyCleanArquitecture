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
        let charactersList = await container.fetchCharacters(page: currentPage)
        return mapper.map(charactersList, currentPage: currentPage)
    }

    func saveCharactersList(_ charactersList: CharacterResult, currentPage: Int) async {

        for character in charactersList.result {

            let characterData = CharactersData(id: character.id,
                                               name: character.name,
                                               status: character.status,
                                               species: character.species,
                                               type: character.type,
                                               gender: character.gender,
                                               image: character.image,
                                               url: character.url,
                                               created: character.url,
                                               page: currentPage,
                                               numPages: charactersList.info.pages,
                                               count: charactersList.info.count)
            await container.insert(charactersDataList: characterData)
        }

        if currentPage == charactersList.info.pages {
            await container.saveData()
        }
    }
}

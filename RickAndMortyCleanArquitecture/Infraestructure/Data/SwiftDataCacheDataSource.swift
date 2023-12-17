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
        let charactersList = container.fetchCharacters()
        return mapper.map(charactersList, currentPage: currentPage)
    }
    
    func saveCharactersList(_ charactersList: CharacterResult, currentPage: Int) async {
        let characterResultData = mapper.map(charactersList, currentPage: currentPage)
        await container.insert(characterResultData)
    }
}

//
//  SwiftDataCacheDataSource.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

class SwiftDataCacheDataSource: CacheCharacterDataSourceType {

    private let container: SwiftDataContainerType

    init(container: SwiftDataContainerType) {
        self.container = container
    }

    func getCharactersList() async -> [Character] {
        let charactersList = container.fetchCharacters()
        return charactersList.map {
            Character(id: $0.id, name: $0.name, status: $0.status, species: $0.species, type: $0.type,
                      gender: $0.gender, origin: Location(name: $0.origin.name, url: $0.origin.url),
                      location: Location(name: $0.location.name, url: $0.location.url), image: $0.image,
                      episode: $0.episode, url: $0.url, created: $0.created)
        }
    }
    
    func saveCharactersList(_ charactersList: [Character]) async {
        let charactersListData = charactersList.map {
            CharactersData(id: $0.id, name: $0.name, status: $0.status, species: $0.species, type: $0.type,
                           gender: $0.gender, origin: LocationData(name: $0.origin.name, url: $0.origin.url),
                           location: LocationData(name: $0.location.name, url: $0.location.url), image: $0.image,
                           episode: $0.episode, url: $0.url, created: $0.created)
        }
        await container.insert(charactersListData)
    }
}

//
//  SingleCharacterRepository.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class SingleCharacterRepository: SingleCharacterRepositoryType {
    private let apiDataSource: APISingleCharacterDataSourceType
    private let errorMapper: RickAndMortyDomainErrorMapper
    private let cacheDataSource: CacheCharacterDataSourceType

    init(apiDataSource: APISingleCharacterDataSourceType,
         errorMapper: RickAndMortyDomainErrorMapper,
         cacheDataSource: CacheCharacterDataSourceType) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.cacheDataSource = cacheDataSource
    }

    func getSingleCharacter(characterId: String) async -> Result<Character, RickAndMortyDomainError> {

        let characterResponse = await apiDataSource.getSingleCharacter(characterId: characterId)

        guard case .success(let characterResponseInfo) = characterResponse else {
            return .failure(errorMapper.map(error: characterResponse.failureValue as? HTTPClientError))
        }

        let characterDomain = Character(id: characterResponseInfo.id, name: characterResponseInfo.name,
                                        status: characterResponseInfo.status, species: characterResponseInfo.species,
                                        type: characterResponseInfo.type, gender: characterResponseInfo.gender,
                                        origin: LocationCharacter(name: characterResponseInfo.origin.name,
                                                                  url: characterResponseInfo.origin.url),
                                        location: LocationCharacter(name: characterResponseInfo.location.name,
                                                                    url: characterResponseInfo.location.url),
                                        image: characterResponseInfo.image, episode: characterResponseInfo.episode,
                                        url: characterResponseInfo.url, created: characterResponseInfo.created)

        return .success(characterDomain)
    }

    func getSingleCharacter(url: URL) async -> Result<Character, RickAndMortyDomainError> {
        let characterResponse = await apiDataSource.getSingleCharacter(url: url)

        guard case .success(let characterResponseInfo) = characterResponse else {
            return .failure(errorMapper.map(error: characterResponse.failureValue as? HTTPClientError))
        }

        let characterDomain = Character(id: characterResponseInfo.id, name: characterResponseInfo.name,
                                        status: characterResponseInfo.status, species: characterResponseInfo.species,
                                        type: characterResponseInfo.type, gender: characterResponseInfo.gender,
                                        origin: LocationCharacter(name: characterResponseInfo.origin.name,
                                                                  url: characterResponseInfo.origin.url),
                                        location: LocationCharacter(name: characterResponseInfo.location.name,
                                                                    url: characterResponseInfo.location.url),
                                        image: characterResponseInfo.image, episode: characterResponseInfo.episode,
                                        url: characterResponseInfo.url, created: characterResponseInfo.created)

        return .success(characterDomain)
    }

}

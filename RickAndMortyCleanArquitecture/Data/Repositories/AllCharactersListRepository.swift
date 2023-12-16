//
//  AllCharactersListRepository.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

class AllCharactersListRepository: AllCharactersListRepositoryType {
    private let apiDataSource: APICharactersDataSourceType
    private let errorMapper: RickAndMortyDomainErrorMapper
    private let cacheDataSource: CacheCharacterDataSourceType
    
    init(apiDataSource: APICharactersDataSourceType, errorMapper: RickAndMortyDomainErrorMapper, cacheDataSource: CacheCharacterDataSourceType) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.cacheDataSource = cacheDataSource
    }
    
    func getAllCharactersList(currentPage: Int) async -> Result<CharacterResult, RickAndMortyDomainError> {
        /*let charactersListCache = await cacheDataSource.getCharactersList(currentPage: currentPage)
        
        if charactersListCache.info.count > -1 {
            return .success(charactersListCache)
        }*/
        
        let charactersList = await apiDataSource.getCharactersList(currentPage: currentPage)
        
        guard case .success(let charactersListInfo) = charactersList else {
            return .failure(errorMapper.map(error: charactersList.failureValue as? HTTPClientError))
        }
        
        let charactersDomain = charactersListInfo.results.map {
            Character(id: $0.id, name: $0.name, status: $0.status, species: $0.species,
                      type: $0.type, gender: $0.gender, origin: Location(name: $0.origin.name, url: $0.origin.url),
                      location: Location(name: $0.location.name, url: $0.location.url), image: $0.image,
                      episode: $0.episode, url: $0.url, created: $0.created)
        }
        let charactersResultDomain = CharacterResult(info:
                                                        InfoResult(count: charactersListInfo.info.count,
                                                                   pages: charactersListInfo.info.pages,
                                                                   next: charactersListInfo.info.next,
                                                                   prev: charactersListInfo.info.prev),
                                                     result: charactersDomain)
        //await cacheDataSource.saveCharactersList(charactersResultDomain)
        
        return .success(charactersResultDomain)
    }
    
}

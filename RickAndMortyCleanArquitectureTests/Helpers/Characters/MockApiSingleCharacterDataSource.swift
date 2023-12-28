//
//  MockApiSingleCharacterDataSource.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 22/12/23.
//

import Foundation
@testable import RickAndMortyCleanArquitecture

class MockApiSingleCharacterDataSource: APISingleCharacterDataSourceType {
    func getSingleCharacter(characterId: String) async -> Result<RickAndMortyCleanArquitecture.CharacterListDTO, RickAndMortyCleanArquitecture.HTTPClientError> {
        let mockInfo = InfoDTO(count: 1, pages: 2, next: "testInfoNext", prev: "testInfoPrev")
        let mockLocationCharacter = LocationCharacterDTO(name: "testNameLocation", url: "testURLLocation")
        let mockEpisodeCharacter = ["testEpisodeCharacter"]
        let mockSingleCharacterDTO = CharacterListDTO(id: 1, name: "testCharacterName", status: "testCharacterStatus", species: "testCharacterSpecie", type: "testCharacterType", gender: "testCharacterGender", origin: mockLocationCharacter, location: mockLocationCharacter, image: "testCharacterImage", episode: mockEpisodeCharacter, url: "testCharacterURL", created: "testCharacterCreated")
        
        return .success(mockSingleCharacterDTO)
    }
    
    func getSingleCharacter(url: URL) async -> Result<RickAndMortyCleanArquitecture.CharacterListDTO, RickAndMortyCleanArquitecture.HTTPClientError> {
        let mockInfo = InfoDTO(count: 1, pages: 2, next: "testInfoNext", prev: "testInfoPrev")
        let mockLocationCharacter = LocationCharacterDTO(name: "testNameLocation", url: "testURLLocation")
        let mockEpisodeCharacter = ["testEpisodeCharacter"]
        let mockSingleCharacterDTO = CharacterListDTO(id: 1, name: "testCharacterName", status: "testCharacterStatus", species: "testCharacterSpecie", type: "testCharacterType", gender: "testCharacterGender", origin: mockLocationCharacter, location: mockLocationCharacter, image: "testCharacterImage", episode: mockEpisodeCharacter, url: "testCharacterURL", created: "testCharacterCreated")
        
        return .success(mockSingleCharacterDTO)
    }
    
    
}

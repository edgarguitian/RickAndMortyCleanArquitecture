//
//  MockApiCharactersDataSource.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import Foundation
@testable import RickAndMortyCleanArquitecture

class MockApiCharactersDataSource: APICharactersDataSourceType {
    func getCharactersList(currentPage: Int) async -> Result<RickAndMortyCleanArquitecture.CharacterResponseDTO, RickAndMortyCleanArquitecture.HTTPClientError> {
        let mockInfo = InfoDTO(count: 1, pages: 2, next: "testInfoNext", prev: "testInfoPrev")
        let mockLocationCharacter = LocationCharacterDTO(name: "testNameLocation", url: "testURLLocation")
        let mockEpisodeCharacter = ["testEpisodeCharacter"]
        let mockCharactersListDTO = [
        CharacterListDTO(id: 1, name: "testCharacterName", status: "testCharacterStatus", species: "testCharacterSpecie", type: "testCharacterType", gender: "testCharacterGender", origin: mockLocationCharacter, location: mockLocationCharacter, image: "testCharacterImage", episode: mockEpisodeCharacter, url: "testCharacterURL", created: "testCharacterCreated")
        ]
        let mockData = CharacterResponseDTO(info: mockInfo, results: mockCharactersListDTO)
        
        
        return .success(mockData)
    }
    
    
}

//
//  APISingleCharacterDataSourceTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class APISingleCharacterDataSourceTests: XCTestCase {

    func test_getSingleCharacter_by_characterId_success() async throws {
        // GIVEN
        let mockHttpClient = MockHTTPClient()
        let apiCharactersDataSource = APISingleCharacterDataSource(httpClient: mockHttpClient)
        let mockInfo = InfoDTO(count: 1, pages: 2, next: "testInfoNext", prev: "testInfoPrev")
        let mockLocationCharacter = LocationCharacterDTO(name: "testNameLocation", url: "testURLLocation")
        let mockEpisodeCharacter = ["testEpisodeCharacter"]
        let mockCharacterListDTO = CharacterListDTO(id: 1, name: "testCharacterName", status: "testCharacterStatus", species: "testCharacterSpecie", type: "testCharacterType", gender: "testCharacterGender", origin: mockLocationCharacter, location: mockLocationCharacter, image: "testCharacterImage", episode: mockEpisodeCharacter, url: "testCharacterURL", created: "testCharacterCreated")
        
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(mockCharacterListDTO)
            
            mockHttpClient.mockResult = .success(jsonData)
            
            // WHEN
            let result = await apiCharactersDataSource.getSingleCharacter(characterId: "1")
            
            // THEN
            switch result {
            case .success(let singleCharacter):
                XCTAssertEqual(singleCharacter.id, 1)
                XCTAssertEqual(singleCharacter.name, "testCharacterName")
                XCTAssertEqual(singleCharacter.status, "testCharacterStatus")
                XCTAssertEqual(singleCharacter.species, "testCharacterSpecie")
                XCTAssertEqual(singleCharacter.type, "testCharacterType")
                XCTAssertEqual(singleCharacter.gender, "testCharacterGender")
                XCTAssertEqual(singleCharacter.origin.name, "testNameLocation")
                XCTAssertEqual(singleCharacter.origin.url, "testURLLocation")
                XCTAssertEqual(singleCharacter.location.name, "testNameLocation")
                XCTAssertEqual(singleCharacter.location.url, "testURLLocation")
                XCTAssertEqual(singleCharacter.image, "testCharacterImage")
                XCTAssertEqual(singleCharacter.episode.first, "testEpisodeCharacter")
                XCTAssertEqual(singleCharacter.url, "testCharacterURL")
                XCTAssertEqual(singleCharacter.created, "testCharacterCreated")

            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        } catch {
            XCTFail("Error: \(error)")
        }
        
        
    }
    
    func test_getSingleCharacter_by_url_success() async throws {
        // GIVEN
        let mockHttpClient = MockHTTPClient()
        let apiCharactersDataSource = APISingleCharacterDataSource(httpClient: mockHttpClient)
        let mockInfo = InfoDTO(count: 1, pages: 2, next: "testInfoNext", prev: "testInfoPrev")
        let mockLocationCharacter = LocationCharacterDTO(name: "testNameLocation", url: "testURLLocation")
        let mockEpisodeCharacter = ["testEpisodeCharacter"]
        let mockCharacterListDTO = CharacterListDTO(id: 1, name: "testCharacterName", status: "testCharacterStatus", species: "testCharacterSpecie", type: "testCharacterType", gender: "testCharacterGender", origin: mockLocationCharacter, location: mockLocationCharacter, image: "testCharacterImage", episode: mockEpisodeCharacter, url: "testCharacterURL", created: "testCharacterCreated")
        
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(mockCharacterListDTO)
            
            mockHttpClient.mockResult = .success(jsonData)
            let url = URL(string: "https://rickandmortyapi.com/api/character/2")!
            
            // WHEN
            let result = await apiCharactersDataSource.getSingleCharacter(url: url)
            
            // THEN
            switch result {
            case .success(let singleCharacter):
                XCTAssertEqual(singleCharacter.id, 1)
                XCTAssertEqual(singleCharacter.name, "testCharacterName")
                XCTAssertEqual(singleCharacter.status, "testCharacterStatus")
                XCTAssertEqual(singleCharacter.species, "testCharacterSpecie")
                XCTAssertEqual(singleCharacter.type, "testCharacterType")
                XCTAssertEqual(singleCharacter.gender, "testCharacterGender")
                XCTAssertEqual(singleCharacter.origin.name, "testNameLocation")
                XCTAssertEqual(singleCharacter.origin.url, "testURLLocation")
                XCTAssertEqual(singleCharacter.location.name, "testNameLocation")
                XCTAssertEqual(singleCharacter.location.url, "testURLLocation")
                XCTAssertEqual(singleCharacter.image, "testCharacterImage")
                XCTAssertEqual(singleCharacter.episode.first, "testEpisodeCharacter")
                XCTAssertEqual(singleCharacter.url, "testCharacterURL")
                XCTAssertEqual(singleCharacter.created, "testCharacterCreated")

            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        } catch {
            XCTFail("Error: \(error)")
        }
    }

}

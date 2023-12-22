//
//  APICharactersDataSourceTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture
final class APICharactersDataSourceTests: XCTestCase {

    func test_getCharactersList_success() async throws {
        // GIVEN
        let mockHttpClient = MockHTTPClient()
        let apiCharactersDataSource = APICharactersDataSource(httpClient: mockHttpClient)
        let mockInfo = InfoDTO(count: 1, pages: 2, next: "testInfoNext", prev: "testInfoPrev")
        let mockLocationCharacter = LocationCharacterDTO(name: "testNameLocation", url: "testURLLocation")
        let mockEpisodeCharacter = ["testEpisodeCharacter"]
        let mockCharactersListDTO = [
        CharacterListDTO(id: 1, name: "testCharacterName", status: "testCharacterStatus", species: "testCharacterSpecie", type: "testCharacterType", gender: "testCharacterGender", origin: mockLocationCharacter, location: mockLocationCharacter, image: "testCharacterImage", episode: mockEpisodeCharacter, url: "testCharacterURL", created: "testCharacterCreated")
        ]
        let mockData = [ CharacterResponseDTO(info: mockInfo, results: mockCharactersListDTO)
        ]
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(mockData)
            
            mockHttpClient.mockResult = .success(jsonData)
            
            // WHEN
            let result = await apiCharactersDataSource.getCharactersList(currentPage: -1)
            
            // THEN
            switch result {
            case .success(let listCharacters):
                XCTAssertEqual(listCharacters.results.count, 1)
                XCTAssertEqual(listCharacters.results.first!.id, 1)
                XCTAssertEqual(listCharacters.results.first!.name, "testCharacterName")
                XCTAssertEqual(listCharacters.results.first!.status, "testCharacterStatus")
                XCTAssertEqual(listCharacters.results.first!.species, "testCharacterSpecie")
                XCTAssertEqual(listCharacters.results.first!.type, "testCharacterType")
                XCTAssertEqual(listCharacters.results.first!.gender, "testCharacterGender")
                XCTAssertEqual(listCharacters.results.first!.origin.name, "testNameLocation")
                XCTAssertEqual(listCharacters.results.first!.origin.url, "testURLLocation")
                XCTAssertEqual(listCharacters.results.first!.location.name, "testNameLocation")
                XCTAssertEqual(listCharacters.results.first!.location.url, "testURLLocation")
                XCTAssertEqual(listCharacters.results.first!.image, "testCharacterImage")
                XCTAssertEqual(listCharacters.results.first!.episode.first, "testEpisodeCharacter")
                XCTAssertEqual(listCharacters.results.first!.url, "testCharacterURL")
                XCTAssertEqual(listCharacters.results.first!.created, "testCharacterCreated")

            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        } catch {
            XCTFail("Error: \(error)")
        }
        
        
    }

}

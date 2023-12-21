//
//  AllCharactersListRepositoryTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class AllCharactersListRepositoryTests: XCTestCase {

    func test_getAllCharactersList() async throws {
        // GIVEN
        let mockApiDataSource = MockApiCharactersDataSource()
        let mockErrorMapper = MockRickAndMortyDomainErrorMapper()
        let repository = AllCharactersListRepository(apiDataSource: mockApiDataSource, errorMapper: mockErrorMapper, cacheDataSource: CharacterListFactory.createCacheDataSource())

        // WHEN
        let result = await repository.getAllCharactersList(currentPage: -1)

        // THEN
        switch result {
        case .success(let listCharacters):
            XCTAssertEqual(listCharacters.result.count, 1)
            XCTAssertEqual(listCharacters.result.first!.id, 1)
            XCTAssertEqual(listCharacters.result.first!.name, "testName1")
            XCTAssertEqual(listCharacters.result.first!.status, "testCharacterStatus")
            XCTAssertEqual(listCharacters.result.first!.species, "testCharacterSpecie")
            XCTAssertEqual(listCharacters.result.first!.type, "testCharacterType")
            XCTAssertEqual(listCharacters.result.first!.gender, "testCharacterGender")
            XCTAssertEqual(listCharacters.result.first!.origin.name, "testNameLocation")
            XCTAssertEqual(listCharacters.result.first!.origin.url, "testURLLocation")
            XCTAssertEqual(listCharacters.result.first!.location.name, "testNameLocation")
            XCTAssertEqual(listCharacters.result.first!.location.url, "testURLLocation")
            XCTAssertEqual(listCharacters.result.first!.image, "testCharacterImage")
            XCTAssertEqual(listCharacters.result.first!.episode.first, "testEpisodeCharacter")
            XCTAssertEqual(listCharacters.result.first!.url, "testCharacterURL")
            XCTAssertEqual(listCharacters.result.first!.created, "testCharacterCreated")
        case .failure(let error):
            XCTFail("Error: \(error)")
        }
    }
    
    func test_search() async throws {
        
    }

}

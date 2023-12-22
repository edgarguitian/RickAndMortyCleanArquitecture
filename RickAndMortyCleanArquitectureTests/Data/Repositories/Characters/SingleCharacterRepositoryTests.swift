//
//  SingleCharacterRepositoryTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class SingleCharacterRepositoryTests: XCTestCase {

    func test_getSingleCharacter_by_characterId_success() async throws {
        // GIVEN
        let mockApiDataSource = MockApiSingleCharacterDataSource()
        let mockErrorMapper = MockRickAndMortyDomainErrorMapper()
        let repository = SingleCharacterRepository(apiDataSource: mockApiDataSource, errorMapper: mockErrorMapper, cacheDataSource: CharacterListFactory.createCacheDataSource())

        // WHEN
        let result = await repository.getSingleCharacter(characterId: "1")

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
    }
    
    func test_getSingleCharacter_by_url_success() async throws {
        // GIVEN
        let mockApiDataSource = MockApiSingleCharacterDataSource()
        let mockErrorMapper = MockRickAndMortyDomainErrorMapper()
        let repository = SingleCharacterRepository(apiDataSource: mockApiDataSource, errorMapper: mockErrorMapper, cacheDataSource: CharacterListFactory.createCacheDataSource())
        let url = URL(string: "https://rickandmortyapi.com/api/character/2")!
        // WHEN
        let result = await repository.getSingleCharacter(url: url)

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
    }

}

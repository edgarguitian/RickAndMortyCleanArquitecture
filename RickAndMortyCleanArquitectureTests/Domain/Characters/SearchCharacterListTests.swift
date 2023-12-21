//
//  SearchCharacterListTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class SearchCharacterListTests: XCTestCase {

    func test_execute_sucesfully_returns_character_result() async throws {
        // GIVEN
        let mockLocationCharacter = LocationCharacter(name: "testLocationName", url: "testLocationUrl")
        let mockEpisodesCharacter = [
            "testEpisodeCharacterURL"
        ]
        
        let mockCharacters = [
        Character(id: 1, name: "testName", status: "testStatus", species: "testSpecies", type: "testType", gender: "testGender", origin: mockLocationCharacter, location: mockLocationCharacter, image: "testImage", episode: mockEpisodesCharacter, url: "testUrl", created: "testCreated")
        ]
        let result: Result<[Character], RickAndMortyDomainError> = .success(mockCharacters)
        let stub = SearchCharactersListRepositoryStub(result: result)
        let sut = SearchCharacterList(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute(searchText: "")

        // THEN
        let capturedSearchCharactesList = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedSearchCharactesList.count, mockCharacters.count)
        XCTAssertEqual(capturedSearchCharactesList.first!.id, 1)
        XCTAssertEqual(capturedSearchCharactesList.first!.name, "testName")
        XCTAssertEqual(capturedSearchCharactesList.first!.status, "testStatus")
        XCTAssertEqual(capturedSearchCharactesList.first!.species, "testSpecies")
        XCTAssertEqual(capturedSearchCharactesList.first!.type, "testType")
        XCTAssertEqual(capturedSearchCharactesList.first!.gender, "testGender")
        XCTAssertEqual(capturedSearchCharactesList.first!.origin.name, "testLocationName")
        XCTAssertEqual(capturedSearchCharactesList.first!.origin.url, "testLocationUrl")
        XCTAssertEqual(capturedSearchCharactesList.first!.location.name, "testLocationName")
        XCTAssertEqual(capturedSearchCharactesList.first!.location.url, "testLocationUrl")
        XCTAssertEqual(capturedSearchCharactesList.first!.image, "testImage")
        XCTAssertEqual(capturedSearchCharactesList.first!.episode.first, "testEpisodeCharacterURL")
        XCTAssertEqual(capturedSearchCharactesList.first!.url, "testUrl")
        XCTAssertEqual(capturedSearchCharactesList.first!.created, "testCreated")

        
    }

}

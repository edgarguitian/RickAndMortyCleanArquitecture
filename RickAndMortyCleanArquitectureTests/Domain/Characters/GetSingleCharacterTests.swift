//
//  GetSingleCharacterTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class GetSingleCharacterTests: XCTestCase {

    func test_execute_characterId_sucesfully_returns_single_character() async throws {
        // GIVEN
        let mockLocationCharacter = LocationCharacter(name: "testLocationName", url: "testLocationUrl")
        let mockEpisodesCharacter = [
            "testEpisodeCharacterURL"
        ]

        let mockCharacter = Character(id: 1, name: "testName", status: "testStatus", species: "testSpecies", type: "testType", gender: "testGender", origin: mockLocationCharacter, location: mockLocationCharacter, image: "testImage", episode: mockEpisodesCharacter, url: "testUrl", created: "testCreated")
        let result: Result<Character, RickAndMortyDomainError> = .success(mockCharacter)
        let stub = SingleCharacterRepositoryStub(result: result)
        let sut = GetSingleCharacter(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute(characterId: "1")

        // THEN
        let capturedSingleCharacter = try XCTUnwrap(capturedResult.get())

        XCTAssertEqual(capturedSingleCharacter.id, 1)
        XCTAssertEqual(capturedSingleCharacter.name, "testName")
        XCTAssertEqual(capturedSingleCharacter.status, "testStatus")
        XCTAssertEqual(capturedSingleCharacter.species, "testSpecies")
        XCTAssertEqual(capturedSingleCharacter.type, "testType")
        XCTAssertEqual(capturedSingleCharacter.gender, "testGender")
        XCTAssertEqual(capturedSingleCharacter.origin.name, "testLocationName")
        XCTAssertEqual(capturedSingleCharacter.origin.url, "testLocationUrl")
        XCTAssertEqual(capturedSingleCharacter.location.name, "testLocationName")
        XCTAssertEqual(capturedSingleCharacter.location.url, "testLocationUrl")
        XCTAssertEqual(capturedSingleCharacter.image, "testImage")
        XCTAssertEqual(capturedSingleCharacter.episode.first, "testEpisodeCharacterURL")
        XCTAssertEqual(capturedSingleCharacter.url, "testUrl")
        XCTAssertEqual(capturedSingleCharacter.created, "testCreated")
    }
    
    func test_execute_characterUrl_sucesfully_returns_single_character() async throws {
        // GIVEN
        let mockLocationCharacter = LocationCharacter(name: "testLocationName", url: "testLocationUrl")
        let mockEpisodesCharacter = [
            "testEpisodeCharacterURL"
        ]

        let mockCharacter = Character(id: 1, name: "testName", status: "testStatus", species: "testSpecies", type: "testType", gender: "testGender", origin: mockLocationCharacter, location: mockLocationCharacter, image: "testImage", episode: mockEpisodesCharacter, url: "testUrl", created: "testCreated")
        let result: Result<Character, RickAndMortyDomainError> = .success(mockCharacter)
        let stub = SingleCharacterRepositoryStub(result: result)
        let sut = GetSingleCharacter(repository: stub)
        let url = URL(string: "https://rickandmortyapi.com/api/character/2")!
        
        // WHEN
        let capturedResult = await sut.execute(url: url)

        // THEN
        let capturedSingleCharacter = try XCTUnwrap(capturedResult.get())

        XCTAssertEqual(capturedSingleCharacter.id, 1)
        XCTAssertEqual(capturedSingleCharacter.name, "testName")
        XCTAssertEqual(capturedSingleCharacter.status, "testStatus")
        XCTAssertEqual(capturedSingleCharacter.species, "testSpecies")
        XCTAssertEqual(capturedSingleCharacter.type, "testType")
        XCTAssertEqual(capturedSingleCharacter.gender, "testGender")
        XCTAssertEqual(capturedSingleCharacter.origin.name, "testLocationName")
        XCTAssertEqual(capturedSingleCharacter.origin.url, "testLocationUrl")
        XCTAssertEqual(capturedSingleCharacter.location.name, "testLocationName")
        XCTAssertEqual(capturedSingleCharacter.location.url, "testLocationUrl")
        XCTAssertEqual(capturedSingleCharacter.image, "testImage")
        XCTAssertEqual(capturedSingleCharacter.episode.first, "testEpisodeCharacterURL")
        XCTAssertEqual(capturedSingleCharacter.url, "testUrl")
        XCTAssertEqual(capturedSingleCharacter.created, "testCreated")
    }

}

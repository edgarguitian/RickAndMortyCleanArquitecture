//
//  GetAllCharactersListTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 20/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class GetAllCharactersListTests: XCTestCase {

    func test_execute_sucesfully_returns_character_list_result() async throws {
        // GIVEN
        let mockInfoCharacterResult = InfoResult(count: 1, pages: 2, next: "testNext", prev: "testPrev")
        let mockLocationCharacter = LocationCharacter(name: "testLocationName", url: "testLocationUrl")
        let mockEpisodesCharacter = [
            "testEpisodeCharacterURL"
        ]
        
        let mockCharacters = [
        Character(id: 1, name: "testName", status: "testStatus", species: "testSpecies", type: "testType", gender: "testGender", origin: mockLocationCharacter, location: mockLocationCharacter, image: "testImage", episode: mockEpisodesCharacter, url: "testUrl", created: "testCreated")
        ]
        let mockCharacter = CharacterResult(info: mockInfoCharacterResult, result: mockCharacters)
        let result: Result<CharacterResult, RickAndMortyDomainError> = .success(mockCharacter)
        let stub = AllCharactersListRepositoryStub(result: result)
        let sut = GetAllCharactersList(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute(currentPage: -1)

        // THEN
        let capturedAllCharactesList = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedAllCharactesList.result.count, mockCharacters.count)
        XCTAssertEqual(capturedAllCharactesList.info.count, 1)
        XCTAssertEqual(capturedAllCharactesList.info.pages, 2)
        XCTAssertEqual(capturedAllCharactesList.info.next, "testNext")
        XCTAssertEqual(capturedAllCharactesList.info.prev, "testPrev")
        XCTAssertEqual(capturedAllCharactesList.result.first!.id, 1)
        XCTAssertEqual(capturedAllCharactesList.result.first!.name, "testName")
        XCTAssertEqual(capturedAllCharactesList.result.first!.status, "testStatus")
        XCTAssertEqual(capturedAllCharactesList.result.first!.species, "testSpecies")
        XCTAssertEqual(capturedAllCharactesList.result.first!.type, "testType")
        XCTAssertEqual(capturedAllCharactesList.result.first!.gender, "testGender")
        XCTAssertEqual(capturedAllCharactesList.result.first!.origin.name, "testLocationName")
        XCTAssertEqual(capturedAllCharactesList.result.first!.origin.url, "testLocationUrl")
        XCTAssertEqual(capturedAllCharactesList.result.first!.location.name, "testLocationName")
        XCTAssertEqual(capturedAllCharactesList.result.first!.location.url, "testLocationUrl")
        XCTAssertEqual(capturedAllCharactesList.result.first!.image, "testImage")
        XCTAssertEqual(capturedAllCharactesList.result.first!.episode.first, "testEpisodeCharacterURL")
        XCTAssertEqual(capturedAllCharactesList.result.first!.url, "testUrl")
        XCTAssertEqual(capturedAllCharactesList.result.first!.created, "testCreated")

        
    }

}

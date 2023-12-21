//
//  GetSingleEpisodeTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class GetSingleEpisodeTests: XCTestCase {

    func test_execute_episodeUrl_sucesfully_returns_single_episode() async throws {
        // GIVEN
        let mockCharactersEpisode = [
            "testCharacterEpisode"
        ]

        let mockCharacter = Episode(id: 1, name: "testEpisodeName", airDate: "testEpisodeAirDate", episode: "testEpisode", characters: mockCharactersEpisode, url: "testEpisodeURL", created: "testEpisodeCreated")
        let result: Result<Episode, RickAndMortyDomainError> = .success(mockCharacter)
        let stub = SingleEpisodeRepositoryStub(result: result)
        let sut = GetSingleEpisode(repository: stub)
        let url = URL(string: "https://rickandmortyapi.com/api/episode/28")!
        
        // WHEN
        let capturedResult = await sut.execute(url: url)

        // THEN
        let capturedSingleEpisode = try XCTUnwrap(capturedResult.get())

        XCTAssertEqual(capturedSingleEpisode.id, 1)
        XCTAssertEqual(capturedSingleEpisode.name, "testEpisodeName")
        XCTAssertEqual(capturedSingleEpisode.airDate, "testEpisodeAirDate")
        XCTAssertEqual(capturedSingleEpisode.episode, "testEpisode")
        XCTAssertEqual(capturedSingleEpisode.characters.first, "testCharacterEpisode")
        XCTAssertEqual(capturedSingleEpisode.url, "testEpisodeURL")
        XCTAssertEqual(capturedSingleEpisode.created, "testEpisodeCreated")
    }

}


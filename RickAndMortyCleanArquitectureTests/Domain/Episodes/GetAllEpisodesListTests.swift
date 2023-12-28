//
//  GetAllEpisodesListTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture
final class GetAllEpisodesListTests: XCTestCase {

    func test_execute_sucesfully_returns_episodes_list_result() async throws {
        // GIVEN
        let mockInfoEpisodeResult = InfoResult(count: 1, pages: 2, next: "testNext", prev: "testPrev")
        let mockCharactersEpisode = [
            "testCharacterEpisode"
        ]
        
        let mockEpisodes = [
            Episode(id: 1, name: "testEpisodeName", airDate: "testEpisodeAirDate", episode: "testEpisode", characters: mockCharactersEpisode, url: "testEpisodeURL", created: "testEpisodeCreated")
        
        ]
        let mockEpisodeResult = EpisodeResult(info: mockInfoEpisodeResult, result: mockEpisodes)
        let result: Result<EpisodeResult, RickAndMortyDomainError> = .success(mockEpisodeResult)
        let stub = AllEpisodesListRepositoryStub(result: result)
        let sut = GetAllEpisodesList(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute(currentPage: -1)

        // THEN
        let capturedAllEpisodesList = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedAllEpisodesList.result.count, mockEpisodes.count)
        XCTAssertEqual(capturedAllEpisodesList.info.count, 1)
        XCTAssertEqual(capturedAllEpisodesList.info.pages, 2)
        XCTAssertEqual(capturedAllEpisodesList.info.next, "testNext")
        XCTAssertEqual(capturedAllEpisodesList.info.prev, "testPrev")
        XCTAssertEqual(capturedAllEpisodesList.result.first!.id, 1)
        XCTAssertEqual(capturedAllEpisodesList.result.first!.name, "testEpisodeName")
        XCTAssertEqual(capturedAllEpisodesList.result.first!.airDate, "testEpisodeAirDate")
        XCTAssertEqual(capturedAllEpisodesList.result.first!.episode, "testEpisode")
        XCTAssertEqual(capturedAllEpisodesList.result.first!.characters.first, "testCharacterEpisode")
        XCTAssertEqual(capturedAllEpisodesList.result.first!.url, "testEpisodeURL")
        XCTAssertEqual(capturedAllEpisodesList.result.first!.created, "testEpisodeCreated")

        
    }

}

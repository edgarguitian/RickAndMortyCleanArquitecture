//
//  AllEpisodesListRepositoryTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class AllEpisodesListRepositoryTests: XCTestCase {

    func test_getEpisodesList_success() async throws {
        // GIVEN
        let mockApiDataSource = MockApiEpisodesDataSource()
        let mockErrorMapper = MockRickAndMortyDomainErrorMapper()
        let repository = AllEpisodesListRepository(apiDataSource: mockApiDataSource, errorMapper: mockErrorMapper, cacheDataSource: EpisodeListFactory.createCacheDataSource())

        // WHEN
        let result = await repository.getAllEpisodesList(currentPage: -1)

        // THEN
        switch result {
        case .success(let episodesList):
            XCTAssertEqual(episodesList.result.count, 1)
            XCTAssertEqual(episodesList.info.count, 1)
            XCTAssertEqual(episodesList.info.pages, 2)
            XCTAssertEqual(episodesList.info.next, "testNext")
            XCTAssertEqual(episodesList.info.prev, "testPrev")
            XCTAssertEqual(episodesList.result.first!.id, 1)
            XCTAssertEqual(episodesList.result.first!.name, "testEpisodeName")
            XCTAssertEqual(episodesList.result.first!.airDate, "testEpisodeAirDate")
            XCTAssertEqual(episodesList.result.first!.episode, "testEpisode")
            XCTAssertEqual(episodesList.result.first!.characters.first, "testCharacterEpisode")
            XCTAssertEqual(episodesList.result.first!.url, "testEpisodeURL")
            XCTAssertEqual(episodesList.result.first!.created, "testEpisodeCreated")
        case .failure(let error):
            XCTFail("Error: \(error)")
        }
    }

}

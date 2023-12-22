//
//  SingleEpisodeRepositoryTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class SingleEpisodeRepositoryTests: XCTestCase {

    func test_getSingleEpisode_by_url_success() async throws {
        // GIVEN
        let mockApiDataSource = MockApiSingleEpisodeDataSource()
        let mockErrorMapper = MockRickAndMortyDomainErrorMapper()
        let repository = SingleEpisodeRepository(apiDataSource: mockApiDataSource, errorMapper: mockErrorMapper, cacheDataSource: EpisodeListFactory.createCacheDataSource())
        let url = URL(string: "https://rickandmortyapi.com/api/episode/28")!
        // WHEN
        let result = await repository.getSingleEpisode(url: url)

        // THEN
        switch result {
        case .success(let singleEpisode):
            XCTAssertEqual(singleEpisode.id, 1)
            XCTAssertEqual(singleEpisode.name, "testEpisodeName")
            XCTAssertEqual(singleEpisode.airDate, "testEpisodeAirDate")
            XCTAssertEqual(singleEpisode.episode, "testEpisode")
            XCTAssertEqual(singleEpisode.characters.first, "testCharacterEpisode")
            XCTAssertEqual(singleEpisode.url, "testEpisodeURL")
            XCTAssertEqual(singleEpisode.created, "testEpisodeCreated")
        case .failure(let error):
            XCTFail("Error: \(error)")
        }
    }

}

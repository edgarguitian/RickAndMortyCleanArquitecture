//
//  APISingleEpisodeDataSourceTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class APISingleEpisodeDataSourceTests: XCTestCase {

    func test_getSingleEpisode_success() async throws {
        // GIVEN
        let mockHttpClient = MockHTTPClient()
        let apiEpisodeDataSource = APISingleEpisodeDataSource(httpClient: mockHttpClient)
        let mockInfo = InfoDTO(count: 1, pages: 2, next: "testInfoNext", prev: "testInfoPrev")
        let mockCharactersEpisode = [
            "testCharacterEpisode"
        ]
        let mockEpisode = EpisodeListDTO(id: 1, name: "testEpisodeName", airDate: "testEpisodeAirDate", episode: "testEpisode", characters: mockCharactersEpisode, url: "testEpisodeUrl", created: "testEpisodeCreated")
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(mockEpisode)
            
            mockHttpClient.mockResult = .success(jsonData)
            let url = URL(string: "https://rickandmortyapi.com/api/episode/28")!
            // WHEN
            let result = await apiEpisodeDataSource.getSingleEpisode(url: url)
            
            // THEN
            switch result {
            case .success(let singleEpisode):
                XCTAssertEqual(singleEpisode.id, 1)
                XCTAssertEqual(singleEpisode.name, "testEpisodeName")
                XCTAssertEqual(singleEpisode.airDate, "testEpisodeAirDate")
                XCTAssertEqual(singleEpisode.episode, "testEpisode")
                XCTAssertEqual(singleEpisode.characters.first, "testCharacterEpisode")
                XCTAssertEqual(singleEpisode.url, "testEpisodeUrl")
                XCTAssertEqual(singleEpisode.created, "testEpisodeCreated")

            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        } catch {
            XCTFail("Error: \(error)")
        }
        
        
    }

}

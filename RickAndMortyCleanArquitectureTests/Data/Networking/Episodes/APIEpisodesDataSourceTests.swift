//
//  APIEpisodesDataSourceTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class APIEpisodesDataSourceTests: XCTestCase {

    func test_getEpisodesList_success() async throws {
        // GIVEN
        let mockHttpClient = MockHTTPClient()
        let apiEpisodesDataSource = APIEpisodesDataSource(httpClient: mockHttpClient)
        let mockInfo = InfoDTO(count: 1, pages: 2, next: "testInfoNext", prev: "testInfoPrev")
        let mockCharactersEpisode = [
            "testCharacterEpisode"
        ]
        let mockEpisodes = [
            EpisodeListDTO(id: 1, name: "testEpisodeName", airDate: "testEpisodeAirDate", episode: "testEpisode", characters: mockCharactersEpisode, url: "testEpisodeUrl", created: "testEpisodeCreated")
        ]

        let mockData = [ EpisodeResponseDTO(info: mockInfo, results: mockEpisodes)
        ]
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(mockData)
            
            mockHttpClient.mockResult = .success(jsonData)
            
            // WHEN
            let result = await apiEpisodesDataSource.getEpisodesList(currentPage: -1)
            
            // THEN
            switch result {
            case .success(let listEpisodes):
                XCTAssertEqual(listEpisodes.results.count, 1)
                XCTAssertEqual(listEpisodes.results.first!.id, 1)
                XCTAssertEqual(listEpisodes.results.first!.name, "testEpisodeName")
                XCTAssertEqual(listEpisodes.results.first!.airDate, "testEpisodeAirDate")
                XCTAssertEqual(listEpisodes.results.first!.episode, "testEpisode")
                XCTAssertEqual(listEpisodes.results.first!.characters.first, "testCharacterEpisode")
                XCTAssertEqual(listEpisodes.results.first!.url, "testEpisodeUrl")
                XCTAssertEqual(listEpisodes.results.first!.created, "testEpisodeCreated")

            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        } catch {
            XCTFail("Error: \(error)")
        }
        
        
    }

}

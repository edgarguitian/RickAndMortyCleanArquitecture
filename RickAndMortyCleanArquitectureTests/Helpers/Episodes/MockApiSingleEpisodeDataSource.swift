//
//  MockApiSingleEpisodeDataSource.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 22/12/23.
//

import Foundation
@testable import RickAndMortyCleanArquitecture

class MockApiSingleEpisodeDataSource: APISingleEpisodeDataSourceType {
    func getSingleEpisode(url: URL) async -> Result<RickAndMortyCleanArquitecture.EpisodeListDTO, RickAndMortyCleanArquitecture.HTTPClientError> {
        let mockInfo = InfoDTO(count: 1, pages: 2, next: "testInfoNext", prev: "testInfoPrev")
        let mockCharactersEpisode = [
            "testCharacterEpisode"
        ]
        let mockSingleEpisodeDTO = EpisodeListDTO(id: 1, name: "testEpisodeName", airDate: "testEpisodeAirDate", episode: "testEpisode", characters: mockCharactersEpisode, url: "testEpisodeURL", created: "testEpisodeCreated")
        
        
        return .success(mockSingleEpisodeDTO)
    }
}

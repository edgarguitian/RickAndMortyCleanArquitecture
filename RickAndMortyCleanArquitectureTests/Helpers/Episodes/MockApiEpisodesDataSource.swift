//
//  MockApiEpisodesDataSource.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 22/12/23.
//

import Foundation
@testable import RickAndMortyCleanArquitecture

class MockApiEpisodesDataSource: APIEpisodesDataSourceType {
    func getEpisodesList(currentPage: Int) async -> Result<RickAndMortyCleanArquitecture.EpisodeResponseDTO, RickAndMortyCleanArquitecture.HTTPClientError> {
        let mockInfo = InfoDTO(count: 1, pages: 2, next: "testInfoNext", prev: "testInfoPrev")
        let mockCharactersEpisode = [
            "testCharacterEpisode"
        ]
        let mockEpisodesListDTO = [
            EpisodeListDTO(id: 1, name: "testEpisodeName", airDate: "testEpisodeAirDate", episode: "testEpisode", characters: mockCharactersEpisode, url: "testEpisodeURL", created: "testEpisodeCreated")
        ]

        let mockData = EpisodeResponseDTO(info: mockInfo, results: mockEpisodesListDTO)
        
        return .success(mockData)
    }
    
    
}

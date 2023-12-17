//
//  APIEpisodesDataSource.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class APIEpisodesDataSource: APIEpisodesDataSourceType {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getEpisodesList(currentPage: Int) async -> Result<EpisodeResponseDTO, HTTPClientError> {
        let queryParameters: [String: Any] = ["page": currentPage]
        
        let endpoint = Endpoint(path: "episode",
                                queryParameters: queryParameters,
                                method: .get)

        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://rickandmortyapi.com/api/")

        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }

        guard let episodesListResponse = try? JSONDecoder().decode(EpisodeResponseDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(episodesListResponse)
    }
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .generic
        }

        return error
    }
}

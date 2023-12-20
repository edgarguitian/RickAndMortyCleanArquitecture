//
//  APISingleEpisodeDataSource.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 20/12/23.
//

import Foundation

class APISingleEpisodeDataSource: APISingleEpisodeDataSourceType {

    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func getSingleEpisode(url: URL) async -> Result<EpisodeListDTO, HTTPClientError> {
        let endpoint = Endpoint(path: "",
                                queryParameters: [:],
                                method: .get)

        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: url.absoluteString)

        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }

        guard let singleEpisodeResponse = try? JSONDecoder().decode(EpisodeListDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(singleEpisodeResponse)
    }

    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .generic
        }

        return error
    }
}

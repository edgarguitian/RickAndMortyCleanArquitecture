//
//  APICharactersDataSource.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

class APICharactersDataSource: APICharactersDataSourceType {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getCharactersList(currentPage: Int) async -> Result<CharacterResponseDTO, HTTPClientError> {
        let queryParameters: [String: Any] = ["page": currentPage]
        
        let endpoint = Endpoint(path: "character",
                                queryParameters: queryParameters,
                                method: .get)

        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://rickandmortyapi.com/api/")

        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }

        guard let charactersListResponse = try? JSONDecoder().decode(CharacterResponseDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(charactersListResponse)
    }
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .generic
        }

        return error
    }
}

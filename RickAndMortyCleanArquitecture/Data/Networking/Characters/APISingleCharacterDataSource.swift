//
//  APISingleCharacterDataSource.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class APISingleCharacterDataSource: APISingleCharacterDataSourceType {

    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func getSingleCharacter(characterId: String) async -> Result<CharacterListDTO, HTTPClientError> {
        let endpoint = Endpoint(path: "character/"+characterId,
                                queryParameters: [:],
                                method: .get)

        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://rickandmortyapi.com/api/")

        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }

        guard let singleCharacterResponse = try? JSONDecoder().decode(CharacterListDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(singleCharacterResponse)
    }

    func getSingleCharacter(url: URL) async -> Result<CharacterListDTO, HTTPClientError> {
        let endpoint = Endpoint(path: "",
                                queryParameters: [:],
                                method: .get)

        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: url.absoluteString)

        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }

        guard let singleCharacterResponse = try? JSONDecoder().decode(CharacterListDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(singleCharacterResponse)
    }

    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .generic
        }

        return error
    }
}

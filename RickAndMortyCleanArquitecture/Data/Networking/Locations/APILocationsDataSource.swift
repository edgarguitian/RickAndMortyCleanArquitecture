//
//  APILocationsDataSource.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class APILocationsDataSource: APILocationsDataSourceType {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getLocationsList(currentPage: Int) async -> Result<LocationResponseDTO, HTTPClientError> {
        let queryParameters: [String: Any] = ["page": currentPage]
        
        let endpoint = Endpoint(path: "location",
                                queryParameters: queryParameters,
                                method: .get)

        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://rickandmortyapi.com/api/")

        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }

        guard let locationsListResponse = try? JSONDecoder().decode(LocationResponseDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(locationsListResponse)
    }
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .generic
        }

        return error
    }
}

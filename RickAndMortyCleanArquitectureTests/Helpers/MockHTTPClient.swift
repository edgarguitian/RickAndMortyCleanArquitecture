//
//  MockHTTPClient.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import Foundation
@testable import RickAndMortyCleanArquitecture

class MockHTTPClient: HTTPClient {

    enum MockResult {
        case success(Data)
        case failure(HTTPClientError)
    }

    var mockResult: MockResult = .success(Data())

    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        switch mockResult {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
}

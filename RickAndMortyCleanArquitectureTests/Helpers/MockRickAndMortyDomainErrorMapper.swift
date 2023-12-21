//
//  MockRickAndMortyDomainErrorMapper.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import Foundation
@testable import RickAndMortyCleanArquitecture

class MockRickAndMortyDomainErrorMapper: RickAndMortyDomainErrorMapper {
    override func map(error: HTTPClientError?) -> RickAndMortyDomainError {
            return .generic
    }
}

//
//  RickAndMortyDomainErrorMapper.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

class RickAndMortyDomainErrorMapper {
    func map(error: HTTPClientError?) -> RickAndMortyDomainError {
        guard error == .tooManyRequests else {
            return .generic
        }

        return .tooManyRequests
    }
}

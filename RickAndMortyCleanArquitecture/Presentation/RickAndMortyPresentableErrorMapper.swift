//
//  RickAndMortyPresentableErrorMapper.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

class RickAndMortyPresentableErrorMapper {
    func map(error: RickAndMortyDomainError?) -> String {
        guard error == .tooManyRequests else {
            return "Something went wrong"
        }

        return "You have exceeded the limit. Try again later"
    }
}

//
//  SingleEpisodeRepositoryStub.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import Foundation
@testable import RickAndMortyCleanArquitecture

class SingleEpisodeRepositoryStub: SingleEpisodeRepositoryType {

    private let result: Result<RickAndMortyCleanArquitecture.Episode, RickAndMortyDomainError>

    init(result: Result<RickAndMortyCleanArquitecture.Episode, RickAndMortyDomainError>) {
        self.result = result
    }
    
    func getSingleEpisode(url: URL) async -> Result<RickAndMortyCleanArquitecture.Episode, RickAndMortyCleanArquitecture.RickAndMortyDomainError> {
        return result
    }
}

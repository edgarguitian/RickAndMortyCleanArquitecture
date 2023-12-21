//
//  AllEpisodesListRepositoryStub.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import Foundation
import Foundation
@testable import RickAndMortyCleanArquitecture

class AllEpisodesListRepositoryStub: AllEpisodesListRepositoryType {

    private let result: Result<RickAndMortyCleanArquitecture.EpisodeResult, RickAndMortyDomainError>

    init(result: Result<RickAndMortyCleanArquitecture.EpisodeResult, RickAndMortyDomainError>) {
        self.result = result
    }

    func getAllEpisodesList(currentPage: Int) async -> Result<RickAndMortyCleanArquitecture.EpisodeResult, RickAndMortyCleanArquitecture.RickAndMortyDomainError> {
        return result
    }
}

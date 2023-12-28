//
//  SearchCharactersListRepositoryStub.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import Foundation
@testable import RickAndMortyCleanArquitecture

class SearchCharactersListRepositoryStub: SearchCharactersListRepositoryType {

    private let result: Result<[RickAndMortyCleanArquitecture.Character], RickAndMortyDomainError>

    init(result: Result<[RickAndMortyCleanArquitecture.Character], RickAndMortyDomainError>) {
        self.result = result
    }

    func search(searchText: String) async -> Result<[RickAndMortyCleanArquitecture.Character], RickAndMortyCleanArquitecture.RickAndMortyDomainError> {
        return result
    }
}

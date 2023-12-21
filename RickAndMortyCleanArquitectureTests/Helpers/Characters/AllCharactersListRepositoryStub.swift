//
//  AllCharactersListRepositoryStub.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 20/12/23.
//

import Foundation
@testable import RickAndMortyCleanArquitecture

class AllCharactersListRepositoryStub: AllCharactersListRepositoryType {

    private let result: Result<CharacterResult, RickAndMortyDomainError>

    init(result: Result<CharacterResult, RickAndMortyDomainError>) {
        self.result = result
    }

    func getAllCharactersList(currentPage: Int) async -> Result<RickAndMortyCleanArquitecture.CharacterResult, RickAndMortyCleanArquitecture.RickAndMortyDomainError> {
        return result
    }
}

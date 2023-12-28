//
//  SingleCharacterRepositoryStub.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import Foundation
@testable import RickAndMortyCleanArquitecture

class SingleCharacterRepositoryStub: SingleCharacterRepositoryType {
    
    

    private let result: Result<Character, RickAndMortyDomainError>

    init(result: Result<Character, RickAndMortyDomainError>) {
        self.result = result
    }

    func getSingleCharacter(characterId: String) async -> Result<RickAndMortyCleanArquitecture.Character, RickAndMortyCleanArquitecture.RickAndMortyDomainError> {
        return result
    }
    
    func getSingleCharacter(url: URL) async -> Result<RickAndMortyCleanArquitecture.Character, RickAndMortyCleanArquitecture.RickAndMortyDomainError> {
        return result
    }
}

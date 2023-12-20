//
//  GetSingleCharacter.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class GetSingleCharacter: GetSingleCharacterType {
    
    
    private let repository: SingleCharacterRepositoryType
    
    init(repository: SingleCharacterRepositoryType) {
        self.repository = repository
    }
    
    func execute(characterId: String) async -> Result<Character, RickAndMortyDomainError> {
        let result = await repository.getSingleCharacter(characterId: characterId)
        
        guard let character = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(character)
    }
    
    func execute(url: URL) async -> Result<Character, RickAndMortyDomainError> {
        let result = await repository.getSingleCharacter(url: url)
        
        guard let character = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(character)
    }
    
}

//
//  GetAllCharactersList.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

class GetAllCharactersList: GetAllCharactersListType {
    private let repository: AllCharactersListRepositoryType

    init(repository: AllCharactersListRepositoryType) {
        self.repository = repository
    }

    func execute(currentPage: Int) async -> Result<CharacterResult, RickAndMortyDomainError> {
        let result = await repository.getAllCharactersList(currentPage: currentPage)

        guard let charactersList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(charactersList)
    }

}

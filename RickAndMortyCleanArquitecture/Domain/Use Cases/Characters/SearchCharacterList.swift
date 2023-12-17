//
//  SearchCharacterList.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class SearchCharacterList: SearchCharactersListType {
    private let repository: SearchCharactersListRepositoryType
    
    init(repository: SearchCharactersListRepositoryType) {
        self.repository = repository
    }
    
    func execute(searchText: String) async -> Result<[Character], RickAndMortyDomainError> {
        let result = await repository.search(searchText: searchText)
        
        guard let charactersList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(charactersList.sorted { $0.id < $1.id})
    }
    
}

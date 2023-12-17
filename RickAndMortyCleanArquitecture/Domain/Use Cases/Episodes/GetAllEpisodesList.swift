//
//  GetAllEpisodesList.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class GetAllEpisodesList: GetAllEpisodesListType {
    private let repository: AllEpisodesListRepositoryType
    
    init(repository: AllEpisodesListRepositoryType) {
        self.repository = repository
    }
    
    func execute(currentPage: Int) async -> Result<EpisodeResult, RickAndMortyDomainError> {
        let result = await repository.getAllEpisodesList(currentPage: currentPage)
        
        guard let locationsList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(locationsList)
    }
    
}

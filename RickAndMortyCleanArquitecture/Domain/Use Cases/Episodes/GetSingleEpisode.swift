//
//  GetSingleEpisode.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 20/12/23.
//

import Foundation

class GetSingleEpisode: GetSingleEpisodeType {
    
    
    private let repository: SingleEpisodeRepositoryType
    
    init(repository: SingleEpisodeRepositoryType) {
        self.repository = repository
    }
    
    
    func execute(url: URL) async -> Result<Episode, RickAndMortyDomainError> {
        let result = await repository.getSingleEpisode(url: url)
        
        guard let episode = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(episode)
    }
    
}

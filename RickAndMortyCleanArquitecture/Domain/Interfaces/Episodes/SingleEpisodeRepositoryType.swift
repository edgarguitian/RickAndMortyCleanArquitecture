//
//  SingleEpisodeRepositoryType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 20/12/23.
//

import Foundation

protocol SingleEpisodeRepositoryType {
    func getSingleEpisode(url: URL) async -> Result<Episode, RickAndMortyDomainError>
}

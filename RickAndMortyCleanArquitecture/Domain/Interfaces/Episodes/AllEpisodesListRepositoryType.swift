//
//  AllEpisodesListRepositoryType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

protocol AllEpisodesListRepositoryType {
    func getAllEpisodesList(currentPage: Int) async -> Result<EpisodeResult, RickAndMortyDomainError>
}

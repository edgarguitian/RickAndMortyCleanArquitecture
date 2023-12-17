//
//  GetAllEpisodesListType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

protocol GetAllEpisodesListType {
    func execute(currentPage: Int) async -> Result<EpisodeResult, RickAndMortyDomainError>
}

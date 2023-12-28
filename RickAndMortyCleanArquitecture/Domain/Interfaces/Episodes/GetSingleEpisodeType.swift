//
//  GetSingleEpisodeType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 20/12/23.
//

import Foundation

protocol GetSingleEpisodeType {
    func execute(url: URL) async -> Result<Episode, RickAndMortyDomainError>
}

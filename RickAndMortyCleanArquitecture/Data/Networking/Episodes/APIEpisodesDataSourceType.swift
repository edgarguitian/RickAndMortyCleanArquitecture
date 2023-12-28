//
//  APIEpisodesDataSourceType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

protocol APIEpisodesDataSourceType {
    func getEpisodesList(currentPage: Int) async -> Result<EpisodeResponseDTO, HTTPClientError>
}

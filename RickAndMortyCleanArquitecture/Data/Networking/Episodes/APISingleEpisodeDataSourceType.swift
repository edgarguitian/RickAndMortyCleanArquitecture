//
//  APISingleEpisodeDataSourceType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 20/12/23.
//

import Foundation

protocol APISingleEpisodeDataSourceType {
    func getSingleEpisode(url: URL) async -> Result<EpisodeListDTO, HTTPClientError>
}

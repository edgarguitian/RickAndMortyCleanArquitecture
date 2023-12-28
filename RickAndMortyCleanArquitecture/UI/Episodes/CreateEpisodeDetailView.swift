//
//  CreateEpisodeDetailView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

protocol CreateEpisodeDetailView {
    func create(episodeDetailInfo: EpisodeListPresentableItem) -> EpisodeDetailView
}

//
//  EpisodeDetailFactory.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class EpisodeDetailFactory: CreateEpisodeDetailView {
    func create(episodeDetailInfo: EpisodeListPresentableItem) -> EpisodeDetailView {
        return EpisodeDetailView(viewModel: createViewModel(episodeDetailInfo: episodeDetailInfo))
    }
    
    private func createViewModel(episodeDetailInfo: EpisodeListPresentableItem) -> EpisodeDetailViewModel {
        return EpisodeDetailViewModel(episodeDetailInfo: episodeDetailInfo, errorMapper: RickAndMortyPresentableErrorMapper())
    }
    
}

//
//  EpisodeDetailViewModel.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class EpisodeDetailViewModel: ObservableObject {
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    @Published var episodeDetailInfo: EpisodeListPresentableItem

    private let errorMapper: RickAndMortyPresentableErrorMapper
    
    init(episodeDetailInfo: EpisodeListPresentableItem, errorMapper: RickAndMortyPresentableErrorMapper) {
        self.episodeDetailInfo = episodeDetailInfo
        self.errorMapper = errorMapper
    }
    
}

//
//  EpisodeListViewModel.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class EpisodeListViewModel: ObservableObject {
    private let getEpisodeList: GetAllEpisodesList
    private let errorMapper: RickAndMortyPresentableErrorMapper
    private var currentPage: Int = 1
    private var lastPage: Int = -1
    @Published var filteredEpisodes: [EpisodeListPresentableItem] = []
    var episodes: [EpisodeListPresentableItem] = []
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    
    @Published var isShowingFilters: Bool = false

    
    init(getEpisodeList: GetAllEpisodesList, errorMapper: RickAndMortyPresentableErrorMapper) {
        self.getEpisodeList = getEpisodeList
        self.errorMapper = errorMapper
    }
    
    func onAppear(isSearch: Bool) {
        if !isSearch {
            if currentPage == 0 {
                showLoadingSpinner = true
            }
            if(lastPage == -1 || lastPage > -1 && currentPage <= lastPage) {
                Task {
                    let result = await getEpisodeList.execute(currentPage: currentPage)
                    handleResult(result)
                }
            }
        }
    }
    
    private func handleResult(_ result: Result<EpisodeResult, RickAndMortyDomainError>) {
        guard case .success(let episodes) = result else {
            handleError(error: result.failureValue as? RickAndMortyDomainError)
            return
        }
        
        let episodesPresentable = episodes.result.map {
            EpisodeListPresentableItem(id: String($0.id),
                                       name: $0.name,
                                       air_date: $0.air_date,
                                       episode: $0.episode,
                                       characters: $0.characters,
                                       url: $0.url,
                                       created: $0.created)
        }
        
        Task { @MainActor in
            if currentPage == 0 {
                showLoadingSpinner = false
            }
            
            self.episodes = self.episodes + episodesPresentable
            self.filteredEpisodes = self.episodes
            self.lastPage = episodes.info.pages
            currentPage += 1
            
        }
    }
    
    private func handleError(error: RickAndMortyDomainError?) {
        Task { @MainActor in
            showLoadingSpinner = false
            showErrorMessage = errorMapper.map(error: error)
        }
    }
}

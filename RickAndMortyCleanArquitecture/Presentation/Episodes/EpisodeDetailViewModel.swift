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
    private let getSingleCharacter: GetSingleCharacterType
    @Published var characters: [SingleCharacterPresentableItem] = []
    private let errorMapper: RickAndMortyPresentableErrorMapper
    
    init(episodeDetailInfo: EpisodeListPresentableItem, getSingleCharacter: GetSingleCharacterType, errorMapper: RickAndMortyPresentableErrorMapper) {
        self.episodeDetailInfo = episodeDetailInfo
        self.errorMapper = errorMapper
        self.getSingleCharacter = getSingleCharacter
    }
    
    func onAppear() {
        showLoadingSpinner = true
        showErrorMessage = nil
        let numCharacters = episodeDetailInfo.characters.count
        for i in 0..<numCharacters {
            Task {
                let result = await getSingleCharacter.execute(url: URL(string: episodeDetailInfo.characters[i])!)
                
                guard case .success(let singleCharacter) = result else {
                    handleError(error: result.failureValue as? RickAndMortyDomainError)
                    return
                }
                
                let singleCharacterPresentable = SingleCharacterPresentableItem(character: singleCharacter)
                print("")
                Task { @MainActor in
                    if i == numCharacters - 1 {
                        showLoadingSpinner = false
                    }
                    self.characters.append(singleCharacterPresentable)
                }

            }
        }
        
    }
    
    private func handleError(error: RickAndMortyDomainError?) {
        Task { @MainActor in
            showLoadingSpinner = false
            showErrorMessage = errorMapper.map(error: error)
        }
    }
    
}

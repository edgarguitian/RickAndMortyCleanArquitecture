//
//  CharacterDetailViewModel.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation
import UIKit

class CharacterDetailViewModel: ObservableObject {
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    @Published var characterDetailInfo: SingleCharacterPresentableItem
    @Published var episodes: [EpisodeListPresentableItem] = []

    private let getSingleCharacter: GetSingleCharacterType
    private let getSingleEpisode: GetSingleEpisodeType

    private let errorMapper: RickAndMortyPresentableErrorMapper
    let characterId: String

    init(getSingleCharacter: GetSingleCharacterType,
         getSingleEpisode: GetSingleEpisodeType,
         errorMapper: RickAndMortyPresentableErrorMapper,
         characterId: String) {
        self.getSingleCharacter = getSingleCharacter
        self.getSingleEpisode = getSingleEpisode
        self.errorMapper = errorMapper
        self.characterId = characterId
        self.characterDetailInfo = SingleCharacterPresentableItem()
    }

    func onAppear() {
        showLoadingSpinner = true
        showErrorMessage = nil

        Task {
            let result = await getSingleCharacter.execute(characterId: characterId)

            guard case .success(let singleCharacter) = result else {
                handleError(error: result.failureValue as? RickAndMortyDomainError)
                return
            }

            let singleCharacterPresentable = SingleCharacterPresentableItem(character: singleCharacter)
            print("")
            Task { @MainActor in
                self.characterDetailInfo = singleCharacterPresentable

                let numEpisodes = characterDetailInfo.episode.count
                for numEpisode in 0..<numEpisodes {
                    Task {
                        let urlEpisode = URL(string: characterDetailInfo.episode[numEpisode])!
                        let result = await getSingleEpisode.execute(url: urlEpisode)

                        guard case .success(let singleCharacter) = result else {
                            handleError(error: result.failureValue as? RickAndMortyDomainError)
                            return
                        }

                        let charactersEpisode = singleCharacter.characters
                        let singleEpisodePresentable = EpisodeListPresentableItem(id: String(singleCharacter.id),
                                                                                  name: singleCharacter.name,
                                                                                  airDate: singleCharacter.airDate,
                                                                                  episode: singleCharacter.episode,
                                                                                  characters: charactersEpisode,
                                                                                  url: singleCharacter.url,
                                                                                  created: singleCharacter.created)
                        print("")
                        Task { @MainActor in
                            if numEpisode == numEpisodes - 1 {
                                showLoadingSpinner = false
                            }
                            self.episodes.append(singleEpisodePresentable)
                        }

                    }
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

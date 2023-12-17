//
//  CharacterDetailViewModel.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    @Published var characterDetailInfo: SingleCharacterPresentableItem

    private let getSingleCharacter: GetSingleCharacterType
    private let errorMapper: RickAndMortyPresentableErrorMapper
    let characterId: String
    
    init(getSingleCharacter: GetSingleCharacterType, errorMapper: RickAndMortyPresentableErrorMapper, characterId: String) {
        self.getSingleCharacter = getSingleCharacter
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
                showLoadingSpinner = false
                self.characterDetailInfo = singleCharacterPresentable
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

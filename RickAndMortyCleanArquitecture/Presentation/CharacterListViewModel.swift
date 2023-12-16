//
//  CharacterListViewModel.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

class CharacterListViewModel: ObservableObject {
    private let getCharacterList: GetAllCharactersList
    private let errorMapper: RickAndMortyPresentableErrorMapper
    private var currentPage: Int = 1
    @Published var characters: [CharacterListPresentableItem] = []
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    @Published var characterDetail: CharacterListPresentableItem?

    init(getCharacterList: GetAllCharactersList, errorMapper: RickAndMortyPresentableErrorMapper) {
        self.getCharacterList = getCharacterList
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        if currentPage == 0 {
            showLoadingSpinner = true
        }
        Task {
            let result = await getCharacterList.execute(currentPage: currentPage)
            handleResult(result, isSearch: false)
        }
    }
    
    private func handleResult(_ result: Result<[Character], RickAndMortyDomainError>, isSearch: Bool) {
        guard case .success(let characters) = result else {
            handleError(error: result.failureValue as? RickAndMortyDomainError)
            return
        }

        let charactersPresentable = characters.map {
            CharacterListPresentableItem(id: String($0.id), name: $0.name,
                                         status: $0.status, species: $0.species,
                                         type: $0.type, gender: $0.gender, image: $0.image)
        }

        Task { @MainActor in
            if currentPage == 0 {
                showLoadingSpinner = false
            }
            if isSearch {
                self.characters = charactersPresentable
            } else {
                self.characters = self.characters + charactersPresentable//self.characters.append(contentsOf: charactersPresentable)
                currentPage += 1
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

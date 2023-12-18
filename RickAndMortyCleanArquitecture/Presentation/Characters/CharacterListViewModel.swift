//
//  CharacterListViewModel.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

class CharacterListViewModel: ObservableObject {
    private let getCharacterList: GetAllCharactersList
    private let searchCharacterList: SearchCharactersListType
    private let errorMapper: RickAndMortyPresentableErrorMapper
    private var currentPage: Int = 41
    private var lastPage: Int = -1
    @Published var filteredCharacters: [CharacterListPresentableItem] = []
    var characters: [CharacterListPresentableItem] = []
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    @Published var characterDetail: CharacterListPresentableItem?
    
    // MARK: Filters
    @Published var isShowingFilters: Bool = false
    var selectedStatusIndex: Int?
    var selectedGenderIndex: Int?
    let charactersStatus: [String] = ["alive", "dead", "unknown"]
    let charactersGender: [String] = ["female", "male", "genderless", "unknown"]
    
    init(getCharacterList: GetAllCharactersList, searchCharacterList: SearchCharactersListType, errorMapper: RickAndMortyPresentableErrorMapper) {
        self.getCharacterList = getCharacterList
        self.searchCharacterList = searchCharacterList
        self.errorMapper = errorMapper
    }
    
    func onAppear(isSearch: Bool) {
        if !isSearch {
            if currentPage == 0 {
                showLoadingSpinner = true
            }
            if(lastPage == -1 || lastPage > -1 && currentPage <= lastPage) {
                Task {
                    let result = await getCharacterList.execute(currentPage: currentPage)
                    handleResult(result)
                }
            }
        }
    }
    
    func search(searchText: String) {
        
        if searchText.isEmpty {
            showLoadingSpinner = false
            filteredCharacters = characters
        } else {
            if searchText.count > 2 {
                Task {
                    let result = await searchCharacterList.execute(searchText: searchText)
                    handleResult(result)
                }
            }
        }
    }
    
    private func handleResult(_ result: Result<[Character], RickAndMortyDomainError>) {
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
            
            showLoadingSpinner = false
            
            
            self.characters = charactersPresentable
            self.filteredCharacters = charactersPresentable
            
        }
    }
    
    private func handleResult(_ result: Result<CharacterResult, RickAndMortyDomainError>) {
        guard case .success(let characters) = result else {
            handleError(error: result.failureValue as? RickAndMortyDomainError)
            return
        }
        
        let charactersPresentable = characters.result.map {
            CharacterListPresentableItem(id: String($0.id), name: $0.name,
                                         status: $0.status, species: $0.species,
                                         type: $0.type, gender: $0.gender, image: $0.image)
        }
        
        Task { @MainActor in
            if currentPage == 0 {
                showLoadingSpinner = false
            }
            
            self.characters = self.characters + charactersPresentable
            self.filteredCharacters = self.characters
            self.lastPage = characters.info.pages
            currentPage += 1
            
        }
    }
    
    private func handleError(error: RickAndMortyDomainError?) {
        Task { @MainActor in
            showLoadingSpinner = false
            showErrorMessage = errorMapper.map(error: error)
        }
    }
    
    func filterCharacters() {
        let hasStatusFilter = selectedStatusIndex != nil
        let hasGenderFilter = selectedGenderIndex != nil

        filteredCharacters = characters.filter { result in
            let matchesStatus = !hasStatusFilter || result.status.lowercased() == charactersStatus[selectedStatusIndex!]
            let matchesGender = !hasGenderFilter || result.gender.lowercased() == charactersGender[selectedGenderIndex!]

            return matchesStatus && matchesGender
        }

        isShowingFilters = false
    }
    
    func resetFilters() {
        selectedStatusIndex = nil
        selectedGenderIndex = nil
        filteredCharacters = characters
        isShowingFilters = false
    }
}

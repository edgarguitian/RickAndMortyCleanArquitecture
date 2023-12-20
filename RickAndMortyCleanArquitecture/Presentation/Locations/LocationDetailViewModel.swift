//
//  LocationDetailViewModel.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class LocationDetailViewModel: ObservableObject {
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    @Published var locationDetailInfo: LocationListPresentableItem
    private let getSingleCharacter: GetSingleCharacterType
    private let errorMapper: RickAndMortyPresentableErrorMapper
    @Published var residents: [SingleCharacterPresentableItem] = []

    init(getSingleCharacter: GetSingleCharacterType,
         locationDetailInfo: LocationListPresentableItem,
         errorMapper: RickAndMortyPresentableErrorMapper) {
        self.locationDetailInfo = locationDetailInfo
        self.errorMapper = errorMapper
        self.getSingleCharacter = getSingleCharacter
    }
    
    func onAppear() {
        showLoadingSpinner = true
        showErrorMessage = nil
        let numResidents = locationDetailInfo.residents.count
        for i in 0..<numResidents {
            Task {
                let result = await getSingleCharacter.execute(url: URL(string: locationDetailInfo.residents[i])!)
                
                guard case .success(let singleCharacter) = result else {
                    handleError(error: result.failureValue as? RickAndMortyDomainError)
                    return
                }
                
                let singleCharacterPresentable = SingleCharacterPresentableItem(character: singleCharacter)
                print("")
                Task { @MainActor in
                    if i == numResidents - 1 {
                        showLoadingSpinner = false
                    }
                    self.residents.append(singleCharacterPresentable)
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

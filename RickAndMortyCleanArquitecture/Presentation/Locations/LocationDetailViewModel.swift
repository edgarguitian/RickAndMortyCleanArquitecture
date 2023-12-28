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
        for numResident in 0..<numResidents {
            Task {
                let urlResident = URL(string: locationDetailInfo.residents[numResident])!
                let result = await getSingleCharacter.execute(url: urlResident)

                guard case .success(let singleCharacter) = result else {
                    handleError(error: result.failureValue as? RickAndMortyDomainError)
                    return
                }

                let singleCharacterPresentable = SingleCharacterPresentableItem(character: singleCharacter)
                print("")
                Task { @MainActor in
                    if numResident == numResidents - 1 {
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

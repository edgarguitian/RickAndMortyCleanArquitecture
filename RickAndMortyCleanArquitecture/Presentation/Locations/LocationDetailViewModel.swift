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

    private let errorMapper: RickAndMortyPresentableErrorMapper
    
    init(locationDetailInfo: LocationListPresentableItem, errorMapper: RickAndMortyPresentableErrorMapper) {
        self.locationDetailInfo = locationDetailInfo
        self.errorMapper = errorMapper
    }
    
}

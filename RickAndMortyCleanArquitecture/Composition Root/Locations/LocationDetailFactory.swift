//
//  LocationDetailFactory.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class LocationDetailFactory: CreateLocationDetailView {
    func create(locationDetailInfo: LocationListPresentableItem) -> LocationDetailView {
        return LocationDetailView(viewModel: createViewModel(locationDetailInfo: locationDetailInfo))
    }
    
    private func createViewModel(locationDetailInfo: LocationListPresentableItem) -> LocationDetailViewModel {
        return LocationDetailViewModel(locationDetailInfo: locationDetailInfo, errorMapper: RickAndMortyPresentableErrorMapper())
    }
    
}

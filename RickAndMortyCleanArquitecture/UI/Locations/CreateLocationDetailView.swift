//
//  CreateLocationDetailView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

protocol CreateLocationDetailView {
    func create(locationDetailInfo: LocationListPresentableItem) -> LocationDetailView
}

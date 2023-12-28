//
//  SwiftDataLocationsContainerType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

protocol SwiftDataLocationsContainerType {
    func fetchLocations() async -> [LocationsData]
    func fetchLocations(page: Int) -> [LocationsData]
    func insert(locationsDataList: LocationsData) async
    func saveData() async
}

//
//  SwiftDataLocationsContainerType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

protocol SwiftDataLocationsContainerType {
    func fetchLocations() async -> [LocationsResultData]
    func insert(locationsResultList: LocationsResultData) async
    func insert(locationsDataList: LocationsData) async
    func insert(infoResultList: InfoResultLocationsData) async
    func saveData() async
}

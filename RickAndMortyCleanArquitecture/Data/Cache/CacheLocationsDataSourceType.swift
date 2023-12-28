//
//  CacheLocationsDataSourceType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

protocol CacheLocationsDataSourceType {
    func getLocationsList(currentPage: Int) async -> LocationResult
    func saveLocationsList(_ locationsList: LocationResult, currentPage: Int) async
}

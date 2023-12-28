//
//  APILocationsDataSourceType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

protocol APILocationsDataSourceType {
    func getLocationsList(currentPage: Int) async -> Result<LocationResponseDTO, HTTPClientError>
}

//
//  AllLocationsListRepositoryType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

protocol AllLocationsListRepositoryType {
    func getAllLocationsList(currentPage: Int) async -> Result<LocationResult, RickAndMortyDomainError>
}

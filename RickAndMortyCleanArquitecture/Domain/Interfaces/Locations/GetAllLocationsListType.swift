//
//  GetAllLocationsListType.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

protocol GetAllLocationsListType {
    func execute(currentPage: Int) async -> Result<LocationResult, RickAndMortyDomainError>
}

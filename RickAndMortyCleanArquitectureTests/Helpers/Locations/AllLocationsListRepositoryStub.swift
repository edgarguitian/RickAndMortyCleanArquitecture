//
//  AllLocationsListRepositoryStub.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import Foundation
@testable import RickAndMortyCleanArquitecture

class AllLocationsListRepositoryStub: AllLocationsListRepositoryType {

    private let result: Result<LocationResult, RickAndMortyDomainError>

    init(result: Result<LocationResult, RickAndMortyDomainError>) {
        self.result = result
    }

    func getAllLocationsList(currentPage: Int) async -> Result<RickAndMortyCleanArquitecture.LocationResult, RickAndMortyCleanArquitecture.RickAndMortyDomainError> {
        return result
    }
}

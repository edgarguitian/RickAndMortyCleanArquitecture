//
//  GetAllLocationsList.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import Foundation

class GetAllLocationsList: GetAllLocationsListType {
    private let repository: AllLocationsListRepositoryType

    init(repository: AllLocationsListRepositoryType) {
        self.repository = repository
    }

    func execute(currentPage: Int) async -> Result<LocationResult, RickAndMortyDomainError> {
        let result = await repository.getAllLocationsList(currentPage: currentPage)

        guard let locationsList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(locationsList)
    }

}

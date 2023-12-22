//
//  MockApiLocationsDataSource.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 22/12/23.
//

import Foundation
@testable import RickAndMortyCleanArquitecture

class MockApiLocationsDataSource: APILocationsDataSourceType {
    func getLocationsList(currentPage: Int) async -> Result<RickAndMortyCleanArquitecture.LocationResponseDTO, RickAndMortyCleanArquitecture.HTTPClientError> {
        let mockInfo = InfoDTO(count: 1, pages: 2, next: "testInfoNext", prev: "testInfoPrev")
        let mockResidentsLocation = [
            "testResidentLocation"
        ]
        let mockLocationsListDTO = [
        LocationListDTO(id: 1, name: "testLocationName", type: "testLocationType", dimension: "testLocationDimension", residents: mockResidentsLocation, url: "testLocationUrl", created: "testLocationCreated")
        ]
        let mockData = LocationResponseDTO(info: mockInfo, results: mockLocationsListDTO)
        
        return .success(mockData)
    }
    
    
}

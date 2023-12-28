//
//  APILocationsDataSourceTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class APILocationsDataSourceTests: XCTestCase {

    func test_getLocationsList_success() async throws {
        // GIVEN
        let mockHttpClient = MockHTTPClient()
        let apiLocationsDataSource = APILocationsDataSource(httpClient: mockHttpClient)
        let mockInfo = InfoDTO(count: 1, pages: 2, next: "testInfoNext", prev: "testInfoPrev")
        let mockResidentsLocation = [
            "testResidentLocation"
        ]
        let mockLocations = [
            LocationListDTO(id: 1, name: "testLocationName", type: "testLocationType", dimension: "testLocationDimension", residents: mockResidentsLocation, url: "testLocationUrl", created: "testLocationCreated")
        ]

        let mockData = [ LocationResponseDTO(info: mockInfo, results: mockLocations)
        ]
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(mockData)
            
            mockHttpClient.mockResult = .success(jsonData)
            
            // WHEN
            let result = await apiLocationsDataSource.getLocationsList(currentPage: -1)
            
            // THEN
            switch result {
            case .success(let listLocations):
                XCTAssertEqual(listLocations.results.count, 1)
                XCTAssertEqual(listLocations.results.first!.id, 1)
                XCTAssertEqual(listLocations.results.first!.name, "testLocationName")
                XCTAssertEqual(listLocations.results.first!.type, "testLocationType")
                XCTAssertEqual(listLocations.results.first!.dimension, "testLocationDimension")
                XCTAssertEqual(listLocations.results.first!.residents.first, "testResidentLocation")
                XCTAssertEqual(listLocations.results.first!.url, "testLocationUrl")
                XCTAssertEqual(listLocations.results.first!.created, "testLocationCreated")

            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        } catch {
            XCTFail("Error: \(error)")
        }
        
        
    }


}

//
//  AllLocationsListRepositoryTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture

final class AllLocationsListRepositoryTests: XCTestCase {

    func test_getLocationsList_success() async throws {
        // GIVEN
        let mockApiDataSource = MockApiLocationsDataSource()
        let mockErrorMapper = MockRickAndMortyDomainErrorMapper()
        let repository = AllLocationsListRepository(apiDataSource: mockApiDataSource, errorMapper: mockErrorMapper, cacheDataSource: LocationListFactory.createCacheDataSource())

        // WHEN
        let result = await repository.getAllLocationsList(currentPage: -1)

        // THEN
        switch result {
        case .success(let locationsList):
            XCTAssertEqual(locationsList.result.count, 1)
            XCTAssertEqual(locationsList.info.count, 1)
            XCTAssertEqual(locationsList.info.pages, 2)
            XCTAssertEqual(locationsList.info.next, "testNext")
            XCTAssertEqual(locationsList.info.prev, "testPrev")
            XCTAssertEqual(locationsList.result.first!.id, 1)
            XCTAssertEqual(locationsList.result.first!.name, "testLocationName")
            XCTAssertEqual(locationsList.result.first!.type, "testLocationType")
            XCTAssertEqual(locationsList.result.first!.dimension, "testLocationDimension")
            XCTAssertEqual(locationsList.result.first!.residents.first, "testResidentLocation")
            XCTAssertEqual(locationsList.result.first!.url, "testLocationUrl")
            XCTAssertEqual(locationsList.result.first!.created, "testLocationCreated")
        case .failure(let error):
            XCTFail("Error: \(error)")
        }
    }

}

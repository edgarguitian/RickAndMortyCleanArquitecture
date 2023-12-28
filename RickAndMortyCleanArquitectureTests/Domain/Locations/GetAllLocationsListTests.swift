//
//  GetAllLocationsListTests.swift
//  RickAndMortyCleanArquitectureTests
//
//  Created by Edgar Guitian Rey on 21/12/23.
//

import XCTest
@testable import RickAndMortyCleanArquitecture
final class GetAllLocationsListTests: XCTestCase {

    func test_execute_sucesfully_returns_locations_list_result() async throws {
        // GIVEN
        let mockInfoLocationResult = InfoResult(count: 1, pages: 2, next: "testNext", prev: "testPrev")
        let mockResidentsLocation = [
            "testResidentLocation"
        ]
        
        let mockLocations = [
        Location(id: 1, name: "testLocationName", type: "testLocationType", dimension: "testLocationDimension", residents: mockResidentsLocation, url: "testLocationUrl", created: "testLocationCreated")
        ]
        let mockLocationResult = LocationResult(info: mockInfoLocationResult, result: mockLocations)
        let result: Result<LocationResult, RickAndMortyDomainError> = .success(mockLocationResult)
        let stub = AllLocationsListRepositoryStub(result: result)
        let sut = GetAllLocationsList(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute(currentPage: -1)

        // THEN
        let capturedAllLocationsList = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedAllLocationsList.result.count, mockLocations.count)
        XCTAssertEqual(capturedAllLocationsList.info.count, 1)
        XCTAssertEqual(capturedAllLocationsList.info.pages, 2)
        XCTAssertEqual(capturedAllLocationsList.info.next, "testNext")
        XCTAssertEqual(capturedAllLocationsList.info.prev, "testPrev")
        XCTAssertEqual(capturedAllLocationsList.result.first!.id, 1)
        XCTAssertEqual(capturedAllLocationsList.result.first!.name, "testLocationName")
        XCTAssertEqual(capturedAllLocationsList.result.first!.type, "testLocationType")
        XCTAssertEqual(capturedAllLocationsList.result.first!.dimension, "testLocationDimension")
        XCTAssertEqual(capturedAllLocationsList.result.first!.residents.first, "testResidentLocation")
        XCTAssertEqual(capturedAllLocationsList.result.first!.url, "testLocationUrl")
        XCTAssertEqual(capturedAllLocationsList.result.first!.created, "testLocationCreated")

        
    }

}

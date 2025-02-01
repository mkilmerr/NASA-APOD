//
//  FetchApodRepositoryTests.swift
//  NASA APODTests
//
//  Created by longarinas on 01/02/25.
//

import XCTest
@testable import NASA_APOD

final class FetchApodRepositoryTests: XCTestCase {

    var sut: FetchApodRepository!
    var mockNetworkClient: MockNetworkClient!

    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        sut = FetchApodRepository(networkClient: mockNetworkClient)
    }

    override func tearDown() {
        sut = nil
        mockNetworkClient = nil
        super.tearDown()
    }

    func testFetchApodSuccess() async throws {
        // Given
        let expectedAPOD = APOD.mock(
            copyright: nil,
            date: "2024-01-31",
            explanation: "Test explanation",
            hdurl: nil,
            mediaType: .image,
            serviceVersion: "test",
            title: "Title test",
            url: "test-url"
        )
        mockNetworkClient.mockResult = .success(expectedAPOD)

        // When
        let result = try await sut.fetchApod(query: .init(date: "2024-01-31"))

        // Then
        XCTAssertEqual(result, expectedAPOD)
    }

    func testFetchApodFailure() async {
        // Given
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockNetworkClient.mockResult = .failure(expectedError)

        // When
        do {
            _ = try await sut.fetchApod(query: .init(date: nil))
            XCTFail("Expected error to be thrown")
        } catch {
            // Then
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}

//
//  GetApodUseCaseTests.swift
//  NASA APODTests
//
//  Created by longarinas on 01/02/25.
//

import XCTest
@testable import NASA_APOD

final class GetApodUseCaseTests: XCTestCase {
    func testExecuteSuccess() async throws {
        // Given
        let (sut, mockRepository) = makeSUT(
           apod: .mock(date: "2022-10-23", title: "Test explanation", url: "url-test")
        )
       
        // When
        let result = try await sut.execute(date: "2022-10-23")
        let expectedAPOD: APOD = .mock(
            date: "2022-10-23",
            title: "Test explanation",
            url: "url-test"
        )
        
        // Then
        XCTAssertNotNil(mockRepository.query)
        XCTAssertEqual(result, expectedAPOD)
    }
    
    func testExecuteFailure() async throws {
        // Given
        let expectedError = NSError(domain: "test", code: -1)
    
        // When
        let (sut, mockRepository) = makeSUT(
            error: expectedError,
            apod: .mock(date: "2022-10-23", title: "Test explanation", url: "url-test")
        )
        
        // Then
    
        do {
            _ = try await sut.execute(date: "2022-10-23")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(mockRepository.error, expectedError)
        }
    }
}

extension GetApodUseCaseTests {
    func makeSUT(error: NSError? = nil, apod: APOD) -> (GetApodUseCase, MockFetchApodRepository) {
        let repository = MockFetchApodRepository(error: error, apod: apod)
        let sut = GetApodUseCase(repository: repository)
        
        return (sut, repository)
    }
}

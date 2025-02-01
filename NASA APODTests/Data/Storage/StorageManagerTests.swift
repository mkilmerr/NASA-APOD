//
//  StorageManagerTests.swift
//  NASA APODTests
//
//  Created by longarinas on 01/02/25.
//

import XCTest
import SwiftData
@testable import NASA_APOD

@MainActor
final class StorageManagerTests: XCTestCase {
    func testAddItem() async throws {
        // Given
        let (sut, modelContext) = try await makeSUT()
        let item = StorageItemMock(id: "1", name: "Test")
        let descriptor = FetchDescriptor<StorageItemMock>()
        let storage = StorageParameters(context: modelContext, descriptor: descriptor)
        
        // When
        let result = sut.add(storage: storage, item: item)
        
        // Then
        XCTAssertTrue(result)
        let fetchedItems = try modelContext.fetch(descriptor)
        XCTAssertEqual(fetchedItems.count, 1)
        XCTAssertEqual(fetchedItems.first, item)
    }
    
    func testRemoveItem() async throws {
        // Given
        let (sut, modelContext) = try await makeSUT()
        let item = StorageItemMock(id: "1", name: "Test")
        modelContext.insert(item)
        try modelContext.save()
        let descriptor = FetchDescriptor<StorageItemMock>()
        
        // When
        let result = sut.remove(context: modelContext, descriptor: descriptor, item: item)
        
        // Then
        XCTAssertTrue(result)
        let fetchedItems = try modelContext.fetch(descriptor)
        XCTAssertTrue(fetchedItems.isEmpty)
    }
    
    func testGetAllItems() async throws {
        // Given
        let (sut, modelContext) = try await makeSUT()
        let items = [StorageItemMock(id: "1", name: "Test1"), StorageItemMock(id: "2", name: "Test2")]
        items.forEach { modelContext.insert($0) }
        try modelContext.save()
        let descriptor = FetchDescriptor<StorageItemMock>()
        let storage = StorageParameters(context: modelContext, descriptor: descriptor)
        
        // When
        let result = sut.getAll(storage: storage)
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(Set(result), Set(items))
    }
    
    func testCheckIfItemIsAlreadyAdded() async throws {
        // Given
        let (sut, modelContext) = try await makeSUT()
        let item = StorageItemMock(id: "1", name: "Test")
        modelContext.insert(item)
        try modelContext.save()
        let descriptor = FetchDescriptor<StorageItemMock>()
        let storage = StorageParameters(context: modelContext, descriptor: descriptor)
        
        // When
        let result = sut.checkIfItemIsAlreadyAdded(storage: storage, item: item)
        
        // Then
        XCTAssertTrue(result)
    }
}

extension StorageManagerTests {
    private func makeSUT() async throws -> (StorageManager, ModelContext) {
        let sut = StorageManager()
        let schema = Schema([StorageItemMock.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        let modelContext = ModelContext(modelContainer)
        
        return (sut, modelContext)
    }
}

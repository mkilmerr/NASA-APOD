//
//  StorageManager.swift
//  NASA APOD
//
//  Created by longarinas on 01/02/25.
//

import Foundation
import SwiftData

typealias StorageParameters<T: PersistentModel> = (context: ModelContext, descriptor: FetchDescriptor<T>)

protocol StorageManagerProtocol {
    func add<T: Equatable>(storage: StorageParameters<T>, item: T) -> Bool
    
    func remove<T: Equatable>(
        context: ModelContext,
        descriptor: FetchDescriptor<T>,
        item: T
    ) -> Bool
    
    func getAll<T: Equatable>(storage: StorageParameters<T>) -> [T]

    func checkIfItemIsAlreadyAdded<T: Equatable>(storage: StorageParameters<T>, item: T) -> Bool
}

final class StorageManager: StorageManagerProtocol {
    public func add<T: Equatable>(
        storage: StorageParameters<T>,
        item: T
    ) -> Bool {
        do {
            let isAlreadyAdded = checkIfItemIsAlreadyAdded(
                storage: storage,
                item: item
            )

            if isAlreadyAdded {
                _ = remove(
                    context: storage.context,
                    descriptor: storage.descriptor,
                    item: item
                )
                return false
            } else {
                storage.context.insert(item)
                try storage.context.save()
                return true
            }
            
        } catch {
            return false
        }
    }
    
    public func remove<T: Equatable>(
        context: ModelContext,
        descriptor: FetchDescriptor<T>,
        item: T
    ) -> Bool {
        do {
            let data = try context.fetch(descriptor)
            if let itemToRemove = data.first(where: { $0 == item }) {
                context.delete(itemToRemove)
                try context.save()
                return true
            }
        } catch {
            return false
        }
        
        return false
    }
    
    public func getAll<T: Equatable>(storage: StorageParameters<T>) -> [T] {
        do {
            return try storage.context.fetch(storage.descriptor)
        } catch {
            return []
        }
    }

    public func checkIfItemIsAlreadyAdded<T: Equatable>(storage: StorageParameters<T>, item: T) -> Bool {
        do {
            let data = try storage.context.fetch(storage.descriptor)
            return data.contains { $0 == item }
        } catch {
            return false
        }
    }
}

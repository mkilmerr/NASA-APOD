//
//  StorageManager+Mock.swift
//  NASA APOD
//
//  Created by longarinas on 01/02/25.
//

import Foundation
import SwiftData

final class StorageManagerMock: StorageManagerProtocol {
    func add<T>(storage: StorageParameters<T>, item: T) -> Bool {
        return false
    }
    
    func remove<T>(context: ModelContext, descriptor: FetchDescriptor<T>, item: T) -> Bool {
        return false
    }
    
    func getAll<T>(storage: StorageParameters<T>) -> [T] {
       return []
    }
    
    func checkIfItemIsAlreadyAdded<T>(storage: StorageParameters<T>, item: T) -> Bool {
        return false
    }
}

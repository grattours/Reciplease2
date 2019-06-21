//
//  TestCoreDataStack.swift
//  Reciplease2Tests
//
//  Created by Luc Derosne on 14/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//


// import Reciplease2
import Foundation
import CoreData
@testable import Reciplease2

class TestCoreDataStack: CoreDataStack {
    convenience init() {
        self.init(modelName: "Reciplease2")
    }
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription =  NSPersistentStoreDescription()
        //persistentStoreDescription.type = NSInMemoryStoreType // incompatible avec NSBatchDeleteRequest
        persistentStoreDescription.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores {
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError(
                    "Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.storeContainer = container
    }
}

//
//  CoreDataStack.swift
//  Reciplease2
//
//  Created by Luc Derosne on 12/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private let modelName: String
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var mainContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
                //                let title = "Error with container"
                //                let body = "Unable to create the store container for dataBase"
                //                let message = [title: body]
                
                //                NotificationCenter.default.post(name: .unableToSaveContext, object: self, userInfo: message)
            }
        }
        return container
    }()
    
    func newDerivedContext() -> NSManagedObjectContext {
        let context = storeContainer.newBackgroundContext()
        return context
    }
    
    func saveContext() {
        saveContext(mainContext)
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        if context != mainContext {
            saveDerivedContext(context)
            return
        }
        
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
                
                //                let title = "Error when saving"
                //                let body = "Unable to save your data, please try again."
                //                let message = [title: body]
                
                //                NotificationCenter.default.post(name: .unableToSaveContext, object: self, userInfo: message)
            }
        }
    }
    
    func saveDerivedContext(_ context: NSManagedObjectContext) {
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
                
                //                let title = "Error when saving"
                //                let body = "Unable to save your data, please try again."
                //                let message = [title: body]
                
                //                NotificationCenter.default.post(name: .unableToSaveContext, object: self, userInfo: message)
            }
            
            self.saveContext(self.mainContext)
        }
    }
}


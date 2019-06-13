//
//  AppDelegate.swift
//  Reciplease2
//
//  Created by Luc Derosne on 12/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static let coreDataStack = CoreDataStack(modelName: "Reciplease2")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.barTintColor = UIColor.black
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

//    func applicationWillTerminate(_ application: UIApplication) {
//        self.saveContext()
//    }
//
//    // MARK: - Core Data stack
//
//    lazy var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "Reciplease2")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

}


//
//  CoreDataStack.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 30/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation
import CoreData
import EncryptedCoreData

class CoreDataStack: NSObject {
    static let moduleName = "QSSample"
    
    private static var sharedCoreDataStack:CoreDataStack = {
        let coreDataStack = CoreDataStack()
        return coreDataStack
    }()
    
    class func shared() -> CoreDataStack {
        return sharedCoreDataStack
    }
    
    func saveMainContext() -> CoreDataError? {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                return CoreDataError.SaveFailed
            }
        }
        return nil
    }
    
    func savePrivateContext() -> CoreDataError?{
        if privateManagedObjectContext.hasChanges {
            do {
                try privateManagedObjectContext.save()
            } catch {
                return CoreDataError.SaveFailed
            }
        }
        return nil
    }
    
    // The managed object model for the application. This property is not optional.
    // It is a fatal error for the application not to be able to find and load its model.
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: CoreDataStack.moduleName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    // The directory the application uses to store the Core Data store file.
    // This code uses a directory named "com.supercarehealth.Video_Library" in
    // the application's documents Application Support directory.
    lazy var applicationDocumentsDirectory: URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }()
    
    // The persistent store coordinator for the application.
    // This implementation creates and returns a coordinator, having added the store for the application to it.
    // This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
    // Create the coordinator and store
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let persistentStoreURL = self.applicationDocumentsDirectory.appendingPathComponent("\(CoreDataStack.moduleName).sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        
        // Adding the journalling mode recommended by apple
        
        var sqliteOptions:NSDictionary = [
            "journal_mode" : "WAL"
        ]
        
        var optionsDictionary:NSDictionary = [
            NSMigratePersistentStoresAutomaticallyOption : true,
            EncryptedStorePassphraseKey : CoreDataStack.moduleName,
            NSSQLitePragmasOption : sqliteOptions,
            NSInferMappingModelAutomaticallyOption : true
        ]
        do {
            try coordinator.addPersistentStore(ofType: EncryptedStoreType,
                                               configurationName: nil,
                                               at: persistentStoreURL,
                                               options: optionsDictionary as? [AnyHashable : Any])
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            //* Replace this with code to handle the error appropriately.
            //* abort() causes the application to generate a crash log and terminate.
            //* We should not use this function in a shipping application,
            //* although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            
            //* If you encounter schema incompatibility errors during development,
            //* we can reduce their frequency by:
            //* Simply deleting the existing store:
            do {
                try FileManager.default.removeItem(at: persistentStoreURL)
            } catch {
                NSLog("Unresolved error \(error)")
            }
            fatalError("Persistent store error! \(error)")
        }
        if coordinator.persistentStores.count == 0 {
            print("There are no stores - something has gone wrong")
        }
        return coordinator
    }()
    
    // Returns the managed object context for the application
    // (which is already bound to the persistent store coordinator for the application.)
    // This property is optional since there are legitimate error conditions that
    // could cause the creation of the context to fail.
    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    
    var TimeStamp: TimeInterval {
        // return NSDate().timeIntervalSince1970
        return Foundation.Date.timeIntervalSinceReferenceDate
    }
    
}


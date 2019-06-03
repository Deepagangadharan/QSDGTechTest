//
//  CoreDataHelper.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 31/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation
import CoreData
class CoreDataHelper {
    static func fetchAll<T>(fetchRequest:NSFetchRequest<NSFetchRequestResult>, context:NSManagedObjectContext)->[T] {
        var result = [T]()
        do{
            let records = try context.fetch(fetchRequest)
            if let records = records as? [T]{
                result = records
            }
        }catch{
            print("Unabled to execute the request")
        }
        return result
    }
    
    static func truncate(fetchRequest:NSFetchRequest<NSFetchRequestResult>, context:NSManagedObjectContext){
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try context.execute(deleteRequest)
        }catch{
            print("Error truncating table")
        }
    }
}

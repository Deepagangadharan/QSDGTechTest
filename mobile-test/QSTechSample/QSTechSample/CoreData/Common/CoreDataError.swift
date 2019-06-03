//
//  CoreDataError.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 30/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation
enum CoreDataError:Error {
    case NotOnMainThread
    case SaveFailed
    case NilManagedObjectContext
    case GeneralError
    
    func message()->String{
        switch self {
        case .NotOnMainThread:
            return "You are trying to call save context on the main context while not been on the main thread"
        case .SaveFailed:
            return "Unresolved error - report as a defect"
        case .NilManagedObjectContext:
            return "Unresolved error - report as a defect"
        case .GeneralError:
            return "There was a general error"
        }
    }
}

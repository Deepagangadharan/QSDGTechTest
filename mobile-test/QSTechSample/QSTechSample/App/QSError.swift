//
//  QSError.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 31/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

enum QSError:Error{
    case generalError
    case parsingError
    case emptyResponse
    case missingOperation
    case coreDataNotOnMainThread
    case coreDataSaveFailed
    case coreDataNilManagedObjectContext
    case serverError
    
    func toString()->String{
        switch self {
        case .generalError:
            return "There was an error. Please try again."
        case .serverError:
            return "Failed to upload"
        case .parsingError:
            return ""
        case .coreDataNotOnMainThread:
            return "You are trying to call save context on the main context while not been on the main thread"
        case .coreDataSaveFailed:
            return "Unresolved error - report as a defect"
        case .coreDataNilManagedObjectContext:
            return "Unresolved error - report as a defect"
        case .emptyResponse:
            return ""
        case .missingOperation:
            return "There is no corresponding operation. Please create the operation."
        }
    }
    
    static func fromCoreDataError(cdError:CoreDataError)->QSError{
        switch cdError {
        case .NotOnMainThread:
            return QSError.coreDataNotOnMainThread
        case .SaveFailed:
            return QSError.coreDataSaveFailed
        case .NilManagedObjectContext:
            return QSError.coreDataNilManagedObjectContext
        case .GeneralError:
            return QSError.generalError
        }
    }
}

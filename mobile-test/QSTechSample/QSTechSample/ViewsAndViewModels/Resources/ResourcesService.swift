//
//  ResourcesService.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 01/06/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

class ResourcesService{
    
    var callback:((Bool,QSError?)->Void)?
    private var operations = [Operation]()
    private let operationQueue = OperationQueue()
    
    func sync(callback:@escaping ((Bool,QSError?)->Void)){
        Categories.truncateAll()
        
        self.callback = callback
        let operationFactory = OperationFactory()
        guard let vacationSpotDownloadOperation = operationFactory.getDownloadOperation(type: .vacationSpotDownloadType, delegate: self, parameters: nil) else {
            callback(false, .missingOperation)
            return
        }
        
        guard let restaurantDownloadOperation = operationFactory.getDownloadOperation(type: .restaurantDownloadType, delegate: self, parameters: nil) else {
            callback(false,.missingOperation)
            return
        }
        
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.isSuspended = true
        operations.append(contentsOf: [vacationSpotDownloadOperation,restaurantDownloadOperation])
        
        operationQueue.addOperations(operations, waitUntilFinished: false)
        operationQueue.isSuspended = false
    }
    
}

extension ResourcesService:OperationDelegate{
    func onError(error: QSError) {
        guard let callback = self.callback else {
            return
        }
        callback(false,error)
    }
    
    func onCompletion() {
        if operations.count > 0
        {
            operations.remove(at: 0)
        }
        if operations.count > 0 {
            //  operationQueue.addOperation(operations[0])
        }else
        {
            guard let callback = self.callback else {
                return
            }
            callback(true,nil)
        }
    }
}

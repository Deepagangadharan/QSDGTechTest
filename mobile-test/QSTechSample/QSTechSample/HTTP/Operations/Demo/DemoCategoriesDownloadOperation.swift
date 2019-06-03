//
//  DemoCategoriesDownloadOperation.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 30/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

class DemoCategoriesDownloadOperation:Operation{
    private let path:String
    private let delegate:OperationDelegate
    
    init(path:String, delegate:OperationDelegate){
        self.path = path
        self.delegate = delegate
    }
    
    override func main() {
        if let path = Bundle.main.path(forResource: path, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(Date.qsDateFormat)
                let referenceData = try! decoder.decode([CategoriesDataResponse].self, from: data)
                if let _ = Categories.saveCategoriesResponse(categoriesResponse: referenceData)
                {
                    self.delegate.onError(error: QSError.parsingError)
                }else{
                    self.delegate.onCompletion()
                }
            } catch {
                self.delegate.onError(error: QSError.emptyResponse)
                return
            }
        }else{
            self.delegate.onError(error: QSError.parsingError)
        }
    }
}

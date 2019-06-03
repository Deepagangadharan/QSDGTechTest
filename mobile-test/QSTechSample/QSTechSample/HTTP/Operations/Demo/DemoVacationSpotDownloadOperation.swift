//
//  DemoVacationSpotDownloadOperation.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 02/06/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

class DemoVacationSpotDownloadOperation:Operation{
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
                let referenceData = try! decoder.decode([CategoryListResponse].self, from: data)
                if let _ = Categories.saveResourceResponse(categoriesResponse: referenceData)
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

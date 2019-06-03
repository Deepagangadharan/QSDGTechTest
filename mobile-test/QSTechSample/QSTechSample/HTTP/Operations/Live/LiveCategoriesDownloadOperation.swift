//
//  LiveCategoriesDownloadOperation.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 31/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

class LiveCategoriesDownloadOperation:Operation{
    private let url:URL
    private let delegate:OperationDelegate
    
    
    init(url:URL, delegate:OperationDelegate){
        self.url = url
        self.delegate = delegate
    }
    
    override func main() {
        
    }
}

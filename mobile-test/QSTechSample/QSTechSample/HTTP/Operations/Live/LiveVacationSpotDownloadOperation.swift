//
//  LiveVacationSpotDownloadOperation.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 02/06/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

class LiveVacationSpotDownloadOperation:Operation{
    private let url:URL
    private let delegate:OperationDelegate
    
    
    init(url:URL, delegate:OperationDelegate){
        self.url = url
        self.delegate = delegate
    }
    
    override func main() {
        
    }
}

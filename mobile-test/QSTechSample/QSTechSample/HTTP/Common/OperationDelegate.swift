//
//  OperationDelegate.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 30/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

protocol OperationDelegate{
    func onError(error:QSError)
    func onCompletion()
}

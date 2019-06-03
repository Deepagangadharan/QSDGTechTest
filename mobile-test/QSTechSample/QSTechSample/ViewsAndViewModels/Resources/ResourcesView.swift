//
//  ResourcesView.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 01/06/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

protocol ResourcesView:NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func showError(error:QSError)
    func submissionSuccessMessage()
    
}

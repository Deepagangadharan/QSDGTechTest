//
//  CategoriesView.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 30/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

protocol CategoriesView:NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func showError(error:QSError)
    func submissionSuccessMessage()

}

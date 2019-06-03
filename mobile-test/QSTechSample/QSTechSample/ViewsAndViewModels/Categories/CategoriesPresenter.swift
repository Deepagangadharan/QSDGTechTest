//
//  CategoriesPresenter.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 30/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

class CategoriesPresenter {
    var view:CategoriesView?
    let service:CategoriesService
    
    init(service:CategoriesService) {
        self.service = service
    }
    
    func attachView(view:CategoriesView){
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
   
    
    func sync()  {
        
        self.view?.startLoading()
        
        service.sync(callback: {
            success,error in
            if !success {
                if let error = error {
                    self.view?.showError(error: error)
                    return
                }else{
                    self.view?.showError(error: .generalError)
                    return
                }
            }
            else{
                
                self.view?.stopLoading()
                self.view?.submissionSuccessMessage()
                return
                
            }
            
        })
    }
    
}

//
//  ResourcesPresenter.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 01/06/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation
class ResourcesPresenter {
    var view:ResourcesView?
    let service:ResourcesService
    
    init(service:ResourcesService) {
        self.service = service
    }
    
    func attachView(view:ResourcesView){
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

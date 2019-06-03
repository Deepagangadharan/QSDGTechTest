//
//  OperationFactory.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 30/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

class OperationFactory {
    
    let variant = Config.variant
    
    func getDownloadOperation(type:QSOperationDownloadType, delegate:OperationDelegate ,parameters:[String :String]?)->Operation?{
        
        switch type {
            
        case .categoriesDownloadType:
            return getCategoryDataOperation(delegate: delegate, variant: variant)
            
        case .restaurantDownloadType:
            return getRestaurantOperation(delegate: delegate, variant: variant)
            
        case .vacationSpotDownloadType:
            return getVacationSpotOperation(delegate: delegate, variant: variant)
        }
        
    }
   
    private func getCategoryDataOperation(delegate:OperationDelegate, variant: BuildVariant)->Operation{
        if variant == .Demo {
            return DemoCategoriesDownloadOperation(path: "categories", delegate: delegate)
        }else{
            return LiveCategoriesDownloadOperation(url: variant.categoryUrl()!, delegate: delegate)
        }
    }
    
    private func getRestaurantOperation(delegate:OperationDelegate, variant: BuildVariant)->Operation{
        if variant == .Demo {
            return DemoRestaurantsDownloadOperation(path: "restaurants", delegate: delegate)
        }else{
            return LiveRestaurantsDownloadOperation(url: variant.categoryListUrl()!, delegate: delegate)
        }
    }
    
    private func getVacationSpotOperation(delegate:OperationDelegate, variant: BuildVariant)->Operation{
        if variant == .Demo {
            return DemoVacationSpotDownloadOperation(path: "vacation-spot", delegate: delegate)
        }else{
            return LiveVacationSpotDownloadOperation(url: variant.categoryListUrl()!, delegate: delegate)
        }
    }
}



//
//  CategoriesDataResponse.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 30/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation


struct CategoriesDataResponse: Codable {
    
    let _id:String
    let updated_at : Date
    let slug: String
    let custom_module_eid: String
    let eid: String
    let title: String
    let description : String?
    let __v: Int
    let _active: Bool
    let created_at : Date
    
    
    
}

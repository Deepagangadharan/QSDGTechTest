//
//  CategoryListResponse.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 30/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

class CategoryListResponse:Codable
    
    
{
    let addresses:[Address]?
    let _id:String
    let slug: String
    let eid: String
    let title: String
    let description : String
    let category_eid : String
    let __v: Int
    let photo : String
    let _active: Bool
    let updated_at : Date
    let created_at : Date
    let bizHours :  [String: [String: String]]?//[BusinessHours]?
    
    let gps:[String:String]?
    
    
    let socialMedia : [String: [String]]? // [SocialMedia]?
    let contactInfo : [String: [String]]?
    let freeText : [FreeText]?
    
    struct BHours :Codable
    {
        let from:String
        let to:String
    }
    
    struct FreeText:Codable
    {
        
    }
    
    struct SocialMedia :Codable
    {
        let youtubeChannel : [String]
        let twitter : [String]
        let facebook : [String]
    }
    
    struct ContactInfo :Codable
    {
        let website : [String]
        let email : [String]
        let phoneNumber : [String]
        let faxNumber : [String]
        let tollFree : [String]
    }
    
    struct BusinessHours :Codable
    {
        let sundayHours : [Sunday]?
        let mondayHours : [Monday]?
        let tuesdayHours : [Tuesday]?
        let wednesdayHours : [Wednesday]?
        let thursdayHours : [Thursday]?
        let fridayHours : [Friday]?
        let saturdayHours : [Saturday]?
        
    }
    
    struct Sunday :Codable
    {
        let from:String
        let to:String
    }
    
    struct Monday :Codable
    {
        let from:String
        let to:String
    }
    
    struct Tuesday :Codable
    {
        let from:String
        let to:String
    }
    
    struct Wednesday :Codable
    {
        let from:String
        let to:String
    }
    
    struct Thursday :Codable
    {
        let from:String
        let to:String
    }
    
    struct Friday :Codable
    {
        let from:String
        let to:String
    }
    struct Saturday :Codable
    {
        let from:String
        let to:String
    }
    
    struct Address:Codable {
        
        let gps:[String:String]?
        let address1:String?
        let label:String?
        let zipCode:String?
        let city:String?
        let state:String?
        let country:String?
        
        struct gps:Codable {
            
            let latitude: String
            let longitude: String
            
        }
    }
}


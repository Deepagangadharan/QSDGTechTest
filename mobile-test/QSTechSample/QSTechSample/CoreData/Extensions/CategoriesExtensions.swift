//
//  CategoriesExtensions.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 30/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation
import CoreData

extension Categories {
    
    static func saveResourceResponse(categoriesResponse:[CategoryListResponse]) -> CoreDataError?{
        for resource in categoriesResponse{
            
            let newResource = Resources(context: CoreDataStack.shared().privateManagedObjectContext)
            newResource.categoryEid = resource.category_eid
            newResource.resourceId = resource._id
            newResource.createdDateTime = resource.created_at
            newResource.photoPath = resource.photo
            newResource.eid = resource.eid
            newResource.isActive = resource._active
            newResource.resourceTitle = resource.title
            newResource.resourceDesc = resource.description
            
            let newContact = Contact(context: CoreDataStack.shared().privateManagedObjectContext)
            for contact in resource.contactInfo!.keys
            {
                switch contact
                {
                    
                case QSContactType.Typeemail:
                    
                    let temp:Array<String> = resource.contactInfo?[contact] ?? [""]
                    newContact.email = temp[0]
                    
                case QSContactType.Typewebsite:
                    let temp:Array<String> = resource.contactInfo?[contact] ?? [""]
                    newContact.website = temp[0]
                    
                case QSContactType.TypetollFree:
                    let temp:Array<String> = resource.contactInfo?[contact] ?? [""]
                    newContact.tollFree = temp[0]
                    
                case QSContactType.TypephoneNumber:
                    let temp:Array<String> = resource.contactInfo?[contact] ?? [""]
                    newContact.phoneNumber = temp[0]
                    
                default:
                    print("do nothing")
                }
                
                
            }
            
            newResource.contacts = newContact
            
            
            if (resource.addresses != nil)
            {
                for address in resource.addresses!
                {
                    let newAddress = Address(context: CoreDataStack.shared().privateManagedObjectContext)
                    
                    newAddress.addressLine1 = address.address1
                    newAddress.city = address.city
                    newAddress.country = address.country
                    newAddress.zipcode = address.zipCode
                    
                    newResource.addToAddresses(newAddress)
                    
                }
            }
            
            if let error = CoreDataStack.shared().savePrivateContext(){
                return error
            }
        }
        return nil
    }
    
    
    
    static func saveCategoriesResponse(categoriesResponse:[CategoriesDataResponse]) -> CoreDataError?{
        
        for existingCategory in categoriesResponse{
            
            let category = Categories(context: CoreDataStack.shared().privateManagedObjectContext)
            category.categoryId = existingCategory._id
            category.categoryTitle = existingCategory.title
            category.createdDateTime = existingCategory.created_at
            category.customModuleEid = existingCategory.custom_module_eid
            category.eid = existingCategory.eid
            category.isActive = existingCategory._active
            
            if let error = CoreDataStack.shared().savePrivateContext(){
                return error
            }
        }
        
        return nil
    }
    
    static func getCategories()->[Categories]{
        
        let categoryDataItems:[Categories] = CoreDataHelper.fetchAll(fetchRequest:requestForTableType(tableCode: "Categories"), context: CoreDataStack.shared().privateManagedObjectContext)
        print(categoryDataItems)
        return categoryDataItems
    }
    
    static func getResources(categoryEid: String, isAscending: Bool)->[Resources]{
        
        let categoryDataItems:[Resources] = CoreDataHelper.fetchAll(fetchRequest:requestForCategoryEid(categoryEid: categoryEid, isAscending: isAscending), context: CoreDataStack.shared().privateManagedObjectContext)
        print(categoryDataItems)
        return categoryDataItems
    }
    
    
    static func requestForCategoryEid(categoryEid: String, isAscending: Bool) -> NSFetchRequest<NSFetchRequestResult>{
        let request:NSFetchRequest<NSFetchRequestResult> = Resources.fetchRequest()
        request.predicate = NSPredicate(format: "categoryEid == %@",categoryEid)
        request.sortDescriptors = [NSSortDescriptor(key: "resourceTitle", ascending: isAscending)]
        return request
    }
    
    
    static func requestForTableType(tableCode:String) -> NSFetchRequest<NSFetchRequestResult>{
        let entityName = String(describing: Categories.self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "categoryId", ascending: true)]
        // request.predicate = NSPredicate(format: "tableCode == %@",tableCode)
        return request
    }
    
    static func truncateAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try CoreDataStack.shared().privateManagedObjectContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                CoreDataStack.shared().privateManagedObjectContext.delete(objectData)
            }
        } catch let error {
            print("Delete all core refefernce data \(entity) error :", error)
        }
    }
}

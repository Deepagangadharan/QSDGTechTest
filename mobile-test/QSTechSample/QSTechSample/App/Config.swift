//
//  AppBuild.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 31/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation

struct Config {
    
    static var variant : BuildVariant  =  BuildVariant.getVariant()
    static var selectedResource = Resources()
    
}

enum BuildVariant{
    case Demo
    case Live
    
    private static let LiveUrl = "https://github.com/quickseries/mobile-test/blob/master/"
    
    func baseUrl() -> String{
        switch self {
        case .Demo:
            return ""
        case .Live:
            return BuildVariant.LiveUrl
        }
    }
    
    static func getVariant() -> BuildVariant {
        #if RELEASE
        return BuildVariant.Live
        #else
        return BuildVariant.Demo
        #endif
    }
    
    func categoryUrl() -> URL?{
        let baseUrl = URL(string:self.baseUrl())
        let url = URL(string: "category/focus-all?apiVersion=4", relativeTo: baseUrl)
        return url
    }
    
    func categoryListUrl() -> URL?{
        let baseUrl = URL(string:self.baseUrl())
        let url = URL(string: "categoryList/focus-all?apiVersion=4", relativeTo: baseUrl)
        return url
    }
   
}

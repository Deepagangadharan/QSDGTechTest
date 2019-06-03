//
//  DateExtensions.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 30/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation


extension Date{
    
    func toQsString()->String{
        let dateFormatter = Date.qsDisplayDateFormat
        let dateAsString = dateFormatter.string(from: self)
        return dateAsString
    }
    
    static let qsDateFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        //2017-08-03T22:12:39.544Z
        //"2019-03-20T14:25:00"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }()
    
    static let qsDisplayDateFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E dd/MM/yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }()
    
}

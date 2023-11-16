//
//  ChuckHelper.swift
//  iOSV3
//
//  Created by Marcus Malmgren on 2023-11-16.
//

import Foundation

class ChuckHelper {
    
    var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    func fixdate(indate : String) -> String {
        
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-DD HH:mm:ssssss"
        
        let thedate = dateformat.date(from: indate)
        
        return "17/12 2023"
    }
    
}

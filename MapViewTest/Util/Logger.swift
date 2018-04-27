//
//  Logger.swift
//  dailyhotel
//
//  Created by Den Jo on 6/16/17.
//  Copyright © 2017 Daily Co., Ltd. All rights reserved.
//

import Foundation

enum LogType: String {
    case info    = "[💬]"
    case warning = "[⚠️]"
    case error   = "[‼️]"
}

#if DEBUG
var dateFormatter: DateFormatter = {
    let dateFormatter        = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return dateFormatter
}()
#endif
    
func log(_ type: LogType = .info, _ message: String = "", _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    #if DEBUG
        var logMessage = ""
        
        // Add file, function name
        if let fileName = file.split(separator: "/").map(String.init).last?.split(separator: ".").map(String.init).first{
            logMessage = "\(dateFormatter.string(from: Date())) \(type.rawValue) [\(fileName)  \(function)]\((type == .info) ? "" : " ✓\(line)")"
        }
        
        // Add message
        if message != "" {
            logMessage = "\(logMessage)  ➜  \(message)"
        }
        print(logMessage)
    #endif
}

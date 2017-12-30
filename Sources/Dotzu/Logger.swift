//
//  LogPrint.swift
//  exampleWindow
//
//  Created by Remi Robert on 17/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

public func print<T>(_ message: T,
                          file: String = #file,
                      function: String = #function,
                          line: Int = #line)
{
    if Logger.shared.enable {
        Logger.shared.handleLog(message, color: nil, file: file, function: function, line: line)
    } else {
        Swift.print(message)
    }
}

public func print<T>(_ message: T,
                       _ color: UIColor?,
                          file: String = #file,
                      function: String = #function,
                          line: Int = #line)
{
    if Logger.shared.enable {
        Logger.shared.handleLog(message, color: color, file: file, function: function, line: line)
    } else {
        Swift.print(message)
    }
}


public class Logger: LogGenerator {
    
    static let shared = Logger()
    private let queue = DispatchQueue(label: "logprint.log.queue")

    var enable: Bool = true

    fileprivate func parseFileInfo(file: String?, function: String?, line: Int?) -> String? {
        guard let file = file, let function = function, let line = line else {return nil}
        guard let fileName = file.components(separatedBy: "/").last else { return nil }
        
        
        return "\(fileName)[\(line)]\(function):\n"
    }

    fileprivate func handleLog(_ message: Any..., color: UIColor?, file: String?, function: String?, line: Int?) {
        if !Logger.shared.enable {
            return
        }
        let fileInfo = parseFileInfo(file: file, function: function, line: line)
        let stringContent = message.reduce("") { result, next -> String in
            return "\(result)\(result.count > 0 ? " " : "")\(next)"
        }

        Logger.shared.queue.async {
            let newLog = Log(content: stringContent, color: color, fileInfo: fileInfo)
            let format = LoggerFormat.format(newLog)
            Swift.print(format.str)
            StoreManager.shared.addLog(newLog)
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            NotificationCenter.default.post(name: NSNotification.Name("refreshLogs"), object: nil, userInfo: nil)
        }
    }
}

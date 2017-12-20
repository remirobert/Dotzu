//
//  LogPrint.swift
//  exampleWindow
//
//  Created by Remi Robert on 17/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

//liman mark
public func print<T>(_ message: T,
                        file: String = #file,
                    function: String = #function,
                        line: Int = #line)
{
//#if DEBUG
    if Logger.shared.enable {
        Logger.handleLog(message, level: .verbose, file: file, function: function, line: line)
    } else {
        Swift.print(message)
    }
//#endif
}

public class Logger: LogGenerator {

    static let shared = Logger()
    private let queue = DispatchQueue(label: "logprint.log.queue")

    var enable: Bool = true

    public static func verbose(_ message: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        handleLog(message, level: .verbose, file: file, function: function, line: line)
    }

    public static func info(_ message: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        handleLog(message, level: .info, file: file, function: function, line: line)
    }

    public static func warning(_ message: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        handleLog(message, level: .warning, file: file, function: function, line: line)
    }

    public static func error(_ message: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        handleLog(message, level: .error, file: file, function: function, line: line)
    }

    fileprivate static func parseFileInfo(file: String?, function: String?, line: Int?) -> String? {
        guard let file = file, let function = function, let line = line else {return nil}
        guard let fileName = file.components(separatedBy: "/").last else { return nil }
        
        //liman mark
        return "\(fileName)[\(line)]\(function):\n"
    }

    fileprivate static func handleLog(_ message: Any..., level: LogLevel, file: String?, function: String?, line: Int?) {
        if !Logger.shared.enable {
            return
        }
        let fileInfo = parseFileInfo(file: file, function: function, line: line)
        let stringContent = message.reduce("") { result, next -> String in
            return "\(result)\(result.characters.count > 0 ? " " : "")\(next)"
        }

        Logger.shared.queue.async {
            let newLog = Log(content: stringContent, fileInfo: fileInfo, level: level)
            let format = LoggerFormat.format(log: newLog)
            Swift.print(format.str)
            StoreManager.shared.addLog(newLog)
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            NotificationCenter.default.post(name: NSNotification.Name("refreshLogs"), object: nil, userInfo: nil)
        }
    }
}

//
//  LoggerObjc.swift
//  Dotzu
//
//  Created by Remi Robert on 18/02/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

public class LoggerObjc: NSObject {
    public static func verbose(_ items: String, file: String = #file, function: String = #function, line: Int = #line) {
        Logger.verbose(items, file: file, function: function, line: line)
    }

    public static func info(_ items: String, file: String = #file, function: String = #function, line: Int = #line) {
        Logger.info(items, file: file, function: function, line: line)
    }

    public static func warning(_ items: String, file: String = #file, function: String = #function, line: Int = #line) {
        Logger.warning(items, file: file, function: function, line: line)
    }

    public static func error(_ items: String, file: String = #file, function: String = #function, line: Int = #line) {
        Logger.error(items, file: file, function: function, line: line)
    }
}

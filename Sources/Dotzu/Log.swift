//
//  Log.swift
//  exampleWindow
//
//  Created by Remi Robert on 17/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class Log {

    let level: LogLevel
    let id: String
    let fileInfo: String?
    let content: String
    let date: Date?
    
    var isTag: Bool = false
    
    init(content: String, fileInfo: String? = nil, level: LogLevel = .verbose) {
        id = NSUUID().uuidString
        self.fileInfo = fileInfo
        self.content = content
        self.level = level
        date = Date()
    }
}


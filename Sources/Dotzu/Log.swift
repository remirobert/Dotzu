//
//  Log.swift
//  exampleWindow
//
//  Created by Remi Robert on 17/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class Log {

    let id: String
    let fileInfo: String?
    let content: String
    let date: Date?
    
    var isTag: Bool = false
    var color: UIColor = UIColor.white
    
    init(content: String, fileInfo: String? = nil) {
        id = NSUUID().uuidString
        self.fileInfo = fileInfo
        self.content = content
        date = Date()
    }
}


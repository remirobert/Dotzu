//
//  Log.swift
//  exampleWindow
//
//  Created by Remi Robert on 17/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class Log: NSObject, NSCoding {

    let level: LogLevel
    let id: String
    let fileInfo: String?
    let content: String
    let date: Date?

    init(content: String, fileInfo: String? = nil, level: LogLevel = .verbose) {
        id = NSUUID().uuidString
        self.fileInfo = fileInfo
        self.content = content
        self.level = level
        date = Date()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(fileInfo, forKey: "fileInfo")
        aCoder.encode(level.rawValue, forKey: "level")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(date, forKey: "date")
    }

    required init?(coder aDecoder: NSCoder) {
        fileInfo = aDecoder.decodeObject(forKey: "fileInfo") as? String
        level = LogLevel(rawValue: aDecoder.decodeInteger(forKey: "level")) ?? .error
        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        content = aDecoder.decodeObject(forKey: "content") as? String ?? ""
        date = aDecoder.decodeObject(forKey: "date") as? Date
    }
}

extension Log: LogProtocol {
    var cell: UITableViewCell.Type {
        return LogTableViewCell.self
    }

    class func source() -> [LogProtocol] {
        let store = StoreManager<Log>(store: .log)
        return store.logs().filter({
            LogLevelFilter.shared.enabled.contains($0.level)
        })
    }
}

//
//  Request.swift
//  exampleWindow
//
//  Created by Remi Robert on 24/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

enum LogRequestMethod {
    case POST, GET, PUT, DELETE
}

class LogRequest: NSObject, NSCoding {

    let id: String
    let url: String
    let date: Date
    let method: String
    let headers: [String: String]?
    var httpBody: Data?
    var code: Int
    var dataResponse: NSData?
    var errorClientDescription: String?
    var duration: Double?

    var colorCode: UIColor {
        return LogCode.color(code: code)
    }

    init(request: NSURLRequest) {
        code = 0
        date = Date()
        id = UUID().uuidString
        method = request.httpMethod ?? "N/A"
        url = request.url?.absoluteString ?? ""
        headers = request.allHTTPHeaderFields
        httpBody = request.httpBody
    }

    func initResponse(response: URLResponse) {
        guard let responseHttp = response as? HTTPURLResponse else {return}
        code = responseHttp.statusCode
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(url, forKey: "url")
        aCoder.encode(method, forKey: "method")
        aCoder.encode(headers, forKey: "headers")
        aCoder.encode(code, forKey: "code")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(dataResponse, forKey: "dataResponse")
        aCoder.encode(errorClientDescription, forKey: "errorClientDescription")
        aCoder.encode(duration, forKey: "duration")
        aCoder.encode(httpBody, forKey: "httpBody")
    }

    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        url = aDecoder.decodeObject(forKey: "url") as? String ?? ""
        method = aDecoder.decodeObject(forKey: "method") as? String ?? ""
        headers = aDecoder.decodeObject(forKey: "headers") as? [String: String]
        code = aDecoder.decodeInteger(forKey: "code") 
        date = aDecoder.decodeObject(forKey: "date") as? Date ?? Date()
        dataResponse = aDecoder.decodeObject(forKey: "dataResponse") as? NSData
        errorClientDescription = aDecoder.decodeObject(forKey: "errorClientDescription") as? String
        duration = aDecoder.decodeObject(forKey: "duration") as? Double
        httpBody = aDecoder.decodeObject(forKey: "httpBody") as? Data
    }
}

extension LogRequest: LogProtocol {
    var cell: UITableViewCell.Type {
        return LogNetworkTableViewCell.self
    }

    class func source() -> [LogProtocol] {
        return StoreManager<LogRequest>(store: .network).logs().filter({
            LogCodeFilter.shared.enabled.contains(LogCode.codeFrom(code: $0.code))
        })
    }
}

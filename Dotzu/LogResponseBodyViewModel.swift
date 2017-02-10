//
//  LogResponseBodyViewModel.swift
//  exampleWindow
//
//  Created by Remi Robert on 29/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class LogResponseBodyViewModel {

    private let data: Data

    var format: String? {
        do {
            let json = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)
            let pretty = try JSONSerialization.data(withJSONObject: json,   options: .prettyPrinted)
            let prettyString = NSString(data: pretty, encoding: String.Encoding.utf8.rawValue) as? String
            return prettyString?.replacingOccurrences(of: "\\/", with: "/")
        } catch {
            return NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as? String
        }
    }

    init(data: Data) {
        self.data = data
    }
}

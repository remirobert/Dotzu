//
//  LogProtocol.swift
//  exampleWindow
//
//  Created by Remi Robert on 24/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

protocol LogProtocol: class {
    var id: String {get}
    var cell: UITableViewCell.Type {get}
    static func source() -> [LogProtocol]
}

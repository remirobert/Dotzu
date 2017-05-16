//
//  UITableViewExtensions.swift
//  exampleWindow
//
//  Created by Remi Robert on 22/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

extension NSObject {
    static var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UITableViewCell {
    static func reuseIdentifier() -> String {
        return self.nameOfClass
    }
}

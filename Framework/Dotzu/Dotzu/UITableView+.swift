//
//  UITableViewExtensions.swift
//  exampleWindow
//
//  Created by Remi Robert on 22/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCellWithNib<T>(cell: T.Type) where T: UITableViewCell {
        let identifier = cell.reuseIdentifier()
        let nib = UINib(nibName: identifier, bundle: Bundle(for: Dotzu.self))
        register(nib, forCellReuseIdentifier: identifier)
    }

    func dequeueCell<T>(cell: T.Type) -> T? where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: cell.reuseIdentifier()) as? T
    }
}

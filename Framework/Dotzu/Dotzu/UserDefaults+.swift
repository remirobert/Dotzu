//
//  UserDefaultsExtensions.swift
//  exampleWindow
//
//  Created by Remi Robert on 22/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

extension UserDefaults {

    func bool2(forKey: String, defaultValue: Bool = true) -> Bool {
        return self.object(forKey: forKey) as? Bool ?? defaultValue
    }
}

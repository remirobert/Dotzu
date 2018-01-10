//
//  ArrayDeepCopy.swift
//  weqwe
//
//  Created by liman on 08/01/2018.
//  Copyright © 2018 liman. All rights reserved.
//

import Foundation

//Protocal that copyable class should conform
protocol Copying {
    init(original: Self)
}

//Concrete class extension
extension Copying {
    func copy() -> Self {
        return Self.init(original: self)
    }
}

//Array extension for elements conforms the Copying protocol
extension Array where Element: Copying {
    func clone() -> Array {
        var copiedArray = Array<Element>()
        for element in self {
            copiedArray.append(element.copy())
        }
        return copiedArray
    }
}

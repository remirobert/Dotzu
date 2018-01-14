//
//  AppDelegate.swift
//  DebugMan
//
//  Created by liman on 13/12/2017.
//  Copyright © 2017 liman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG
            //step 1: initialize DebugMan
            DebugMan.shared.enable()
        #endif
        
        return true
    }
}

public func print<T>(file: String = #file,
                     function: String = #function,
                     line: Int = #line,
                     _ message: T,
                     _ color: UIColor? = nil)
{
    #if DEBUG
        //step 2: override system print method
        DebugManLog(file, function, line, message, color)
    #endif
}

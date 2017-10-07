//
//  AppDelegate.swift
//  ExampleDotzu
//
//  Created by Remi Robert on 16/05/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Dotzu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let config = DotzuConfig()
        // To show manager view comment (or change showManagerView = true) and restart
        config.showManagerView = false
        Dotzu.setUp(config: config)
        Dotzu.sharedManager.enable()

        return true
    }
}

// One of the way to show Dotzu logs view
#if DEBUG
extension UIWindow {

    override open func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if let controller = Dotzu.sharedManager.managerViewController() {
                self.rootViewController?.present(controller, animated: true, completion: nil)
            }
        }
    }
}
#endif

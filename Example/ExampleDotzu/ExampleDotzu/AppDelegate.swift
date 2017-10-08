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

        // Customize Dotzu programmatically using LogSettings.
        // Some of the LogSettings options are also available inside Dotzu Settings user interface.
        //
        // Following example shows how to use Dotzu without bubble head.
        // Example uses shake gesture to launch Dotzu Manager
        /*
         // Set up LogSettings before enabling Dotzu
         LogsSettings.shared.showBubbleHead = false
         */
        Dotzu.sharedManager.enable()

        return true
    }
}

// One of the way to show Dotzu Manager
#if DEBUG
    extension UIWindow {

        override open func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
            if motion == .motionShake {
                if let controller = Dotzu.sharedManager.viewController() {
                    self.rootViewController?.present(controller, animated: true, completion: nil)
                }
            }
        }
    }
#endif

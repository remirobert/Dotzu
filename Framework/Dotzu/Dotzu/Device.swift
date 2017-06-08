//
//  Device.swift
//  exampleWindow
//
//  Created by Remi Robert on 18/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

struct Device {
    let deviceModel: DeviceModel = DeviceModel.current
    
    var osVersion: String?
    var screenResolution: String!
    var aspectRatio: String?
    var screenSize: Float = 0.0
    
    init() {
        self.screenResolution = self.deviceScreenResolution()
        self.screenSize = self.deviceScreenSize()
    }
    
    private func deviceScreenResolution() -> String {
        let scale = UIScreen.main.scale
        let dimension = UIScreen.main.bounds
        return "\(dimension.size.width*scale)*\(dimension.size.height*scale)"
    }
    
    private func deviceScreenSize() -> Float {
        switch self.deviceModel {
        case .iPhone4, .iPhone4S:                                               return 3.5
        case .iPodTouch1Gen, .iPodTouch2Gen, .iPodTouch3Gen, .iPodTouch4Gen:    return 3.5
        case .iPodTouch5Gen, .iPodTouch6Gen:                                    return 4
        case .iPhone5, .iPhone5C, .iPhone5S, .iPhoneSE:                         return 4
        case .iPhone6, .iPhone6S, .iPhone7:                                     return 4.7
        case .iPhone6Plus, .iPhone6SPlus, .iPhone7Plus:                         return 5.5
        case .iPad1, .iPad2, .iPad3, .iPad4, .iPadAir, .iPadAir2:               return 9.7
        case .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4:                     return 7.9
        case .iPadPro:                                                          return 12.9
        case .unknown, .simulator:                                              return 0
        }
    }
}


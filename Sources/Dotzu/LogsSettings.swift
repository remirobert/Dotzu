//
//  LogsSettings.swift
//  exampleWindow
//
//  Created by Remi Robert on 18/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

class LogsSettings {

    static let shared = LogsSettings()

    var foo: Bool = false
    
    
    var isControllerPresent: Bool {
        didSet {
            UserDefaults.standard.set(isControllerPresent, forKey: "isControllerPresent")
            UserDefaults.standard.synchronize()
            
            //第一响应者链
            if isControllerPresent == true {
                Dotzu.sharedManager.window.makeKeyAndVisible()
                foo = true
                JxbDebugTool.shareInstance().showDebugWin()
            }else{
                if foo == true {
                    if let window = UIApplication.shared.delegate?.window {
                        window?.makeKeyAndVisible()
                    }
                    JxbDebugTool.shareInstance().hideDebugWin()
                }
            }
        }
    }
    
    var mockTimeoutInterval: TimeInterval {
        didSet {
            UserDefaults.standard.set(mockTimeoutInterval, forKey: "mockTimeoutInterval")
            UserDefaults.standard.synchronize()
        }
    }
    var isBallShowScreen: Bool {
        didSet {
            UserDefaults.standard.set(isBallShowScreen, forKey: "isBallShowScreen")
            UserDefaults.standard.synchronize()
        }
    }
    var mainHost: String? = nil {
        didSet {
            UserDefaults.standard.set(mainHost, forKey: "mainHost")
            UserDefaults.standard.synchronize()
        }
    }
    var tabBarSelectItem: Int {
        didSet {
            UserDefaults.standard.set(tabBarSelectItem, forKey: "tabBarSelectItem")
            UserDefaults.standard.synchronize()
        }
    }
    var onlyHosts: [String]? = nil {
        didSet {
            JxbDebugTool.shareInstance().onlyHosts = onlyHosts
        }
    }
    var ignoredHosts: [String]? = nil {
        didSet {
            JxbDebugTool.shareInstance().ignoredHosts = ignoredHosts
        }
    }
    var maxLogsCount: Int {
        didSet {
            UserDefaults.standard.set(maxLogsCount, forKey: "maxLogsCount")
            UserDefaults.standard.synchronize()
            JxbDebugTool.shareInstance().maxLogsCount = maxLogsCount
        }
    }
    var logHeadFrameX: Float {
        didSet {
            UserDefaults.standard.set(logHeadFrameX, forKey: "logHeadFrameX")
            UserDefaults.standard.synchronize()
        }
    }
    var logHeadFrameY: Float {
        didSet {
            UserDefaults.standard.set(logHeadFrameY, forKey: "logHeadFrameY")
            UserDefaults.standard.synchronize()
        }
    }
    var logSearchWord: String? = nil {
        didSet {
            UserDefaults.standard.set(logSearchWord, forKey: "logSearchWord")
            UserDefaults.standard.synchronize()
        }
    }
    var networkSearchWord: String? = nil {
        didSet {
            UserDefaults.standard.set(networkSearchWord, forKey: "networkSearchWord")
            UserDefaults.standard.synchronize()
        }
    }
    var extraControllers: [UIViewController]? = nil
    
    
    
    private init()
    {
        //liman mark
        mainHost = UserDefaults.standard.string(forKey: "mainHost") ?? ""
        maxLogsCount = UserDefaults.standard.integer(forKey: "maxLogsCount")
        mockTimeoutInterval = UserDefaults.standard.double(forKey: "mockTimeoutInterval")
        isBallShowScreen = UserDefaults.standard.bool(forKey: "isBallShowScreen")
        isControllerPresent = UserDefaults.standard.bool(forKey: "isControllerPresent")
        tabBarSelectItem = UserDefaults.standard.integer(forKey: "tabBarSelectItem")
        logHeadFrameX = UserDefaults.standard.float(forKey: "logHeadFrameX")
        logHeadFrameY = UserDefaults.standard.float(forKey: "logHeadFrameY")
        logSearchWord = UserDefaults.standard.string(forKey: "logSearchWord") ?? ""
        networkSearchWord = UserDefaults.standard.string(forKey: "networkSearchWord") ?? ""
    }
}

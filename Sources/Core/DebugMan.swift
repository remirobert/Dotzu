//
//  DebugMan.swift
//  PhiSpeaker
//
//  Created by liman on 26/11/2017.
//  Copyright © 2017 Phicomm. All rights reserved.
//

import Foundation
import UIKit

public class DebugMan : NSObject {
    
    //MARK: - init method
    public static let shared = DebugMan()
    private override init() {
        super.init()
//#if DEBUG
    NotificationCenter.default.addObserver(self, selector: #selector(methodThatIsCalledAfterShake), name: NSNotification.Name(DHCSHakeNotificationName), object: nil)
    
    LogsSettings.shared.isControllerPresent = false
    LogsSettings.shared.logSearchWord = nil
    LogsSettings.shared.networkSearchWord = nil
    
    let _ = StoreManager.shared
//#endif
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - Usage of DebugMan:
    
    /// launchShow: Whether to display the debug panel when the APP starts, the default display (是否APP启动时就显示调试面板, 默认显示)
    /// serverHost: if the URL contains serverHost, then overstriking this URL to be marked, the default is none (加粗标记URL地址, 默认没有)
    /// extraControllers: Extra controllers to be added as child controllers of UITabBarController, the default is none (额外给UITabBarController增加的子控制器, 默认没有)
    /// ignoredHosts: Set the domain hosts which are not crawled, ignore the case, crawl all domain hosts when the default is nil (设置不抓取的域名, 忽略大小写, 为nil时默认抓取所有)
    /// onlyHosts: Set the domain hosts which are only crawled, ignore the case, crawl all domain hosts when the default is nil (设置只抓取的域名, 忽略大小写, 为nil时默认抓取所有)
    /// maxLogsCount: Custom logs/network/crash maximum record amount, the default is 100 (if exceed maximum record amount, it will automatically clear the earliest record, and update the recent record) (自定义logs/network/crash最大记录, 默认100条 (超过会自动清除最早的记录,并更新最近记录))
    /// mockTimeoutInterval: When mock network request, set the timeout interval, the default is 10 seconds (mock网络请求时, 设置的超时时间, 默认10秒)
    public func enable(_ launchShow: Bool = true, serverHost: String? = nil, extraControllers: [UIViewController]? = nil, ignoredHosts: [String]? = nil, onlyHosts: [String]? = nil, maxLogsCount: Int = 100, mockTimeoutInterval: TimeInterval = 10) {
//#if DEBUG
    if serverHost == nil {
        LogsSettings.shared.serverHost = ""
    }else{
        LogsSettings.shared.serverHost = serverHost
    }
    if extraControllers == nil {
        LogsSettings.shared.extraControllers = []
    }else{
        LogsSettings.shared.extraControllers = extraControllers
    }
    if onlyHosts == nil {
        LogsSettings.shared.onlyHosts = []
    }else{
        LogsSettings.shared.onlyHosts = onlyHosts
    }
    if ignoredHosts == nil {
        LogsSettings.shared.ignoredHosts = []
    }else{
        LogsSettings.shared.ignoredHosts = ignoredHosts
    }
    if launchShow == true {
        LogsSettings.shared.isBallShowScreen = true
    }else {
        LogsSettings.shared.isBallShowScreen = false
        return
    }
    
    Dotzu.sharedManager.enable()
    JxbDebugTool.shareInstance().enable()
    LogsSettings.shared.isBallShowScreen = true
    
    LogsSettings.shared.maxLogsCount = maxLogsCount
    LogsSettings.shared.mockTimeoutInterval = mockTimeoutInterval
//#endif
    }
    
    
    public func disable() {
        Dotzu.sharedManager.disable()
        JxbDebugTool.shareInstance().disable()
        LogsSettings.shared.isBallShowScreen = false
    }
    
    
    //MARK: - notification
    @objc private func methodThatIsCalledAfterShake() {
        
        if LogsSettings.shared.isControllerPresent == true {
            return
        }
        
        if LogsSettings.shared.isBallShowScreen == false {
            guard let extraControllers = LogsSettings.shared.extraControllers else {
                return //code never go here
            }
            enable(serverHost: LogsSettings.shared.serverHost, extraControllers: extraControllers, ignoredHosts: LogsSettings.shared.ignoredHosts, onlyHosts: LogsSettings.shared.onlyHosts)
        }
        else if LogsSettings.shared.isBallShowScreen == true {
            disable()
        }
    }
}

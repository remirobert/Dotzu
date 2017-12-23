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
    
    //MARK: - ****************** Usage of DebugMan ******************
    
    /// launchShow: Whether to display the debug panel when the APP starts. the default display (是否APP启动时就显示调试面板, 默认显示)
    /// mainHost: if URLs contain mainHost ,set these URLs bold font to be marked. the default is none (加粗标记URL地址, 默认没有)
    /// ignoredHosts: Set the domain hosts which are not crawled, ignore the case, crawl all domain hosts when the value is nil. the default is nil (设置不抓取的域名, 忽略大小写, 为nil时默认抓取所有, 默认值为nil)
    /// onlyHosts: Set the domain hosts which are only crawled, ignore the case, crawl all domain hosts when the value is nil. the default is nil (设置只抓取的域名, 忽略大小写, 为nil时默认抓取所有, 默认值为nil)
    /// maxLogsCount: Custom logs/network/crash maximum record amount, the default is 100 (if exceed maximum record amount, it will automatically clear the earliest record, and update the recent record) (自定义logs/network/crash最大记录, 默认100条 (超过会自动清除最早的记录,并更新最近记录))
    /// mockTimeoutInterval: When mock network request, set the timeout interval, the default is 10 seconds (mock网络请求时, 设置的超时时间, 默认10秒)
    /// extraControllers: Extra controllers to be added as child controllers of UITabBarController. the default is none (额外给UITabBarController增加的子控制器, 默认没有)
    public func enable(_ launchShow: Bool = true, mainHost: String? = nil, ignoredHosts: [String]? = nil, onlyHosts: [String]? = nil, maxLogsCount: Int = 100, mockTimeoutInterval: TimeInterval = 10, extraControllers: [UIViewController]? = nil) {
//#if DEBUG
    if mainHost == nil {
        LogsSettings.shared.mainHost = ""
    }else{
        LogsSettings.shared.mainHost = mainHost
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
        LogsSettings.shared.isBallShow = true
    }else {
        LogsSettings.shared.isBallShow = false
        return
    }
    
    Dotzu.sharedManager.enable()
    JxbDebugTool.shareInstance().enable()
    Logger.shared.enable = true
    LoggerCrash.shared.enable = true
    LogsSettings.shared.isBallShow = true
    
    LogsSettings.shared.maxLogsCount = maxLogsCount
    LogsSettings.shared.mockTimeoutInterval = mockTimeoutInterval
//#endif
    }
    
    
    //MARK: - private method
    private func disable() {
        Dotzu.sharedManager.disable()
        JxbDebugTool.shareInstance().disable()
        Logger.shared.enable = false
        LoggerCrash.shared.enable = false
        LogsSettings.shared.isBallShow = false
    }
    
    
    //MARK: - init method
    public static let shared = DebugMan()
    private override init() {
        super.init()
        //#if DEBUG
        NotificationCenter.default.addObserver(self, selector: #selector(methodThatIsCalledAfterShake), name: NSNotification.Name(DHCSHakeNotificationName), object: nil)
        
        LogsSettings.shared.logSearchWord = nil
        LogsSettings.shared.networkSearchWord = nil
        
        let _ = StoreManager.shared
        //#endif
    }
    
    
    //MARK: - deinit method
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - notification method
    @objc private func methodThatIsCalledAfterShake() {
        
        if LogsSettings.shared.isBallShow == false {
            guard let extraControllers = LogsSettings.shared.extraControllers else {return}
            
            enable(mainHost: LogsSettings.shared.mainHost, ignoredHosts: LogsSettings.shared.ignoredHosts, onlyHosts: LogsSettings.shared.onlyHosts, extraControllers: extraControllers)
        }
        else if LogsSettings.shared.isBallShow == true {
            disable()
        }
    }
}

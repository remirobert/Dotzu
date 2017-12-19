//
//  LogHeadView.swift
//  exampleWindow
//
//  Created by Remi Robert on 20/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

protocol LogHeadViewDelegate: class {
    func didTapLogHeadView()
}

private let _width: CGFloat = 130/2
private let _height: CGFloat = 130/2

class LogHeadView: UIView {
    
    weak var delegate: LogHeadViewDelegate?
    
    public let width: CGFloat = _width
    public let height: CGFloat = _height
    private var timer: Timer? //liman mark
    
    //liman mark
    private lazy var label: UILabel! = {
        let label = UILabel(frame: CGRect(x:_width/8, y:_height/2 - 14.5/2, width:_width/8*6, height:14.5))
        label.textColor = Color.mainGreen
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = JxbDebugTool.shareInstance().bytesOfUsedMemory()
        return label
    }()
    
    
    static var originalPosition: CGPoint {
        //liman mark
        if LogsSettings.shared.logHeadFrameX != 0 && LogsSettings.shared.logHeadFrameY != 0 {
            return CGPoint(x: CGFloat(LogsSettings.shared.logHeadFrameX), y: CGFloat(LogsSettings.shared.logHeadFrameY))
        }
        return CGPoint(x: UIScreen.main.bounds.size.width - _width/8*7, y: UIScreen.main.bounds.size.height/2 - _height/2)
    }
    
    static var size: CGSize {return CGSize(width: _width, height: _height)}
    
    //MARK: - tool
    fileprivate func initLabelEvent(content: String) {
        let label = UILabel()
        label.frame = CGRect(x: self.frame.size.width/2 - 25/2, y: self.frame.size.height/2 - 25/2, width: 25, height: 25)
        label.text = content
        self.addSubview(label)
        UIView.animate(withDuration: 0.8, animations: {
            label.frame.origin.y = -100
            label.alpha = 0
        }, completion: { _ in
            label.removeFromSuperview()
        })
    }
    
    fileprivate func initLabelEvent2(content: String) {
        let label2 = UILabel()
        label2.frame = CGRect(x: self.center.x - 25/2, y: self.center.y - 25/2, width: 25, height: 25)
        label2.text = content
        self.superview?.addSubview(label2)
        UIView.animate(withDuration: 0.8, animations: {
            label2.frame.origin.y = self.center.y - 100
            label2.alpha = 0
        }, completion: { _ in
            label2.removeFromSuperview()
        })
    }
    
    fileprivate func initLayer() {
        self.backgroundColor = UIColor.black
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.8
        self.layer.cornerRadius = _height/2
        self.layer.shadowOffset = CGSize.zero
        self.sizeToFit()
        self.layer.masksToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = _height/2
        gradientLayer.colors = Color.colorGradientHead
        self.layer.addSublayer(gradientLayer)
                
        self.addSubview(label)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LogHeadView.tap))
        self.addGestureRecognizer(tapGesture)
    }
    
    func changeSideDisplay() {
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
        }, completion: nil)
    }
    
    func updateOrientation(newSize: CGSize) {
        let oldSize = CGSize(width: newSize.height, height: newSize.width)
        let percent = center.y / oldSize.height * 100
        let newOrigin = newSize.height * percent / 100
        let originX = frame.origin.x < newSize.height / 2 ? _width/8*3 : newSize.width - _width/8*3
        self.center = CGPoint(x: originX, y: newOrigin)
    }
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayer()
        
        //网络通知
        NotificationCenter.default.addObserver(self, selector: #selector(reloadHttp_notification(_ :)), name: NSNotification.Name(kNotifyKeyReloadHttp), object: nil)
        
        //内存监控
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerMonitor), userInfo: nil, repeats: true)
        guard let timer = timer else {return}//code never go here
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        timer?.invalidate()
    }
    
    //MARK: - notification
    //网络通知
    @objc func reloadHttp_notification(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo else {return}
        let statusCode = userInfo["statusCode"] as? String
        
        if statusCode == "200" {
            DispatchQueue.main.async { [weak self] in
                self?.initLabelEvent(content: "🚀")
                self?.initLabelEvent2(content: "🚀")
            }
        }else{
            DispatchQueue.main.async { [weak self] in
                self?.initLabelEvent(content: "❌")
                self?.initLabelEvent2(content: "❌")
            }
        }
    }
    
    //MARK: - target action
    //内存监控
    @objc func timerMonitor() {
        label.text = JxbDebugTool.shareInstance().bytesOfUsedMemory()
    }
    
    @objc func tap() {
        delegate?.didTapLogHeadView()
        
        LogsSettings.shared.isControllerPresent = true //liman mark
    }
}


//
//  LogHeadView.swift
//  exampleWindow
//
//  Created by Remi Robert on 20/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

protocol LogHeadViewDelegate: class {
    func didTapButton()
}

class LogHeadView: UIView {

    weak var delegate: LogHeadViewDelegate?
    private var obsLog: NotificationObserver<LogLevel>!
    
    private var timer: Timer? //liman mark

    //liman mark
    private lazy var label: UILabel! = {
        let frame = CGRect(origin: CGPoint(x: 20, y: 20), size: CGSize(width: 40, height: 40))
        let label = UILabel(frame: frame)
        label.textColor = Color.mainGreen
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = JxbDebugTool.shareInstance().bytesOfUsedMemory()
        return label
    }()
    
    static var originalPosition: CGPoint {
        return CGPoint(x: -10, y: UIScreen.main.bounds.size.height - 90) //liman mark
    }
    static var size: CGSize {return CGSize(width: 80, height: 80)}


    fileprivate func initLabelEvent(content: String) {
        let view = UILabel()
        view.frame = CGRect(x: self.frame.size.width / 2 - 12.5,
                            y: self.frame.size.height / 2 - 25, width: 25, height: 25)
        view.text = content
        self.addSubview(view)
        UIView.animate(withDuration: 0.8, animations: {
            view.frame.origin.y = -100
            view.alpha = 0
        }, completion: { _ in
            view.removeFromSuperview()
        })
    }

    fileprivate func initLayer() {
        backgroundColor = UIColor.black
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.8
        layer.cornerRadius = 40
        layer.shadowOffset = CGSize.zero
        sizeToFit()
        layer.masksToBounds = true

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 40
        gradientLayer.colors = Color.colorGradientHead
        layer.addSublayer(gradientLayer)

        addSubview(label)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LogHeadView.tap))
        addGestureRecognizer(tapGesture)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayer()
        
        //liman mark
        
        //网络通知
        NotificationCenter.default.addObserver(self, selector: #selector(reloadHttp_notification), name: NSNotification.Name(kNotifyKeyReloadHttp), object: nil)
        
        //内存监控
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerMonitor), userInfo: nil, repeats: true)
        guard let timer = timer else {
            return //code never go here
        }
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
    }
    
    //网络通知
    @objc func reloadHttp_notification() {
        DispatchQueue.main.async { [weak self] in
            self?.initLabelEvent(content: "🚀") //liman mark
        }
    }
    
    //内存监控
    @objc func timerMonitor() {
        label.text = JxbDebugTool.shareInstance().bytesOfUsedMemory()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        timer?.invalidate()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeSideDisplay(left: Bool) {
        if left {
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
//                self.badge.frame.origin.x = 60
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
//                self.badge.frame.origin.x = 20 - self.badge.frame.size.width
            }, completion: nil)
        }
    }

    func updateOrientation(newSize: CGSize) {
        let oldSize = CGSize(width: newSize.height, height: newSize.width)
        let percent = center.y / oldSize.height * 100
        let newOrigin = newSize.height * percent / 100
        let originX = frame.origin.x < newSize.height / 2 ? 30 : newSize.width - 30
        self.center = CGPoint(x: originX, y: newOrigin)
    }
    
    //MARK: - target action
    @objc func tap() {
        delegate?.didTapButton()
        
        LogsSettings.shared.isControllerPresent = true //liman mark
    }
}

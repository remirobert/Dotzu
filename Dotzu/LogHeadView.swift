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
    private var obsNetwork: NotificationObserver<Void>!

    private var badge: LogBadgeView!
    private lazy var imageView: UIImageView! = {
        let frame = CGRect(origin: CGPoint(x: 20, y: 20), size: CGSize(width: 40, height: 40))
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo", in: Bundle(for: LogHeadView.self), compatibleWith: nil)
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Color.mainGreen
        imageView.layer.cornerRadius = 40
        return imageView
    }()

    static var originalPosition: CGPoint {
        return CGPoint(x: -10, y: UIScreen.main.bounds.size.height / 2)
    }
    static var size: CGSize {return CGSize(width: 80, height: 80)}

    fileprivate func initBadgeView() {
        clipsToBounds = false
        badge = LogBadgeView(frame: CGRect(x: 60, y: 0, width: 30, height: 20))
        addSubview(badge)
    }

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

        addSubview(imageView)
        initBadgeView()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LogHeadView.tap))
        addGestureRecognizer(tapGesture)

        self.obsLog = NotificationObserver(notification: LogNotificationApp.newLog, block: { level in
            guard let level = level as? LogLevel, level == .warning || level == .error else {return}
            DispatchQueue.main.async {
                self.initLabelEvent(content: level.notificationText)
            }
        })
        self.obsNetwork = NotificationObserver(notification: LogNotificationApp.newRequest, block: { _ in
            DispatchQueue.main.async {
                self.initLabelEvent(content: "🚀")
            }
        })
    }

    @objc func tap() {
        delegate?.didTapButton()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeSideDisplay(left: Bool) {
        if left {
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.badge.frame.origin.x = 60
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.badge.frame.origin.x = 20 - self.badge.frame.size.width
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
}

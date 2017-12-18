//
//  ManagerViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 02/12/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class ManagerViewController: UIViewController, LogHeadViewDelegate {

    var logHeadView = LogHeadView(frame: CGRect(origin: LogHeadView.originalPosition, size: LogHeadView.size))

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.view.addSubview(self.logHeadView)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.logHeadView.updateOrientation(newSize: size)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.logHeadView.delegate = self
        self.view.backgroundColor = UIColor.clear
        let selector = #selector(ManagerViewController.panDidFire(panner:))
        let panGesture = UIPanGestureRecognizer(target: self, action: selector)
        logHeadView.addGestureRecognizer(panGesture)
    }

    func didTapLogHeadView() {
        Dotzu.sharedManager.displayedList = true
        let storyboard = UIStoryboard(name: "Manager", bundle: Bundle(for: ManagerViewController.self))
        guard let controller = storyboard.instantiateInitialViewController() else {
            return
        }
        self.present(controller, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        Dotzu.sharedManager.displayedList = false
    }

    @objc func panDidFire(panner: UIPanGestureRecognizer) {
        
        if panner.state == .began {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: { [weak self] in
                self?.logHeadView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: nil)
        }

        let offset = panner.translation(in: view)
        panner.setTranslation(CGPoint.zero, in: view)
        var center = logHeadView.center
        center.x += offset.x
        center.y += offset.y
        logHeadView.center = center

        if panner.state == .ended || panner.state == .cancelled {

            let location = panner.location(in: view)
            let velocity = panner.velocity(in: view)

            var finalX: Double = Double(self.logHeadView.width/8*3)
            var finalY: Double = Double(location.y)

            if location.x > UIScreen.main.bounds.size.width / 2 {
                finalX = Double(UIScreen.main.bounds.size.width) - Double(self.logHeadView.width/8*3)
            }
            
            self.logHeadView.changeSideDisplay()

            let horizentalVelocity = abs(velocity.x)
            let positionX = abs(finalX - Double(location.x))

            let velocityForce = sqrt(pow(velocity.x, 2) * pow(velocity.y, 2))

            let durationAnimation = (velocityForce > 1000.0) ? min(0.3, positionX / Double(horizentalVelocity)) : 0.3

            if velocityForce > 1000.0 {
                finalY += Double(velocity.y) * durationAnimation
            }

            if finalY > Double(UIScreen.main.bounds.size.height) - Double(self.logHeadView.height/8*5) {
                finalY = Double(UIScreen.main.bounds.size.height) - Double(self.logHeadView.height/8*5)
            } else if finalY < Double(self.logHeadView.height/8*5) {
                finalY = Double(self.logHeadView.height/8*5)
            }

            UIView.animate(withDuration: durationAnimation * 5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 6, options: UIViewAnimationOptions.allowUserInteraction, animations: { [weak self] in
                    self?.logHeadView.center = CGPoint(x: finalX, y: finalY)
                    self?.logHeadView.transform = CGAffineTransform.identity
                }, completion: { [weak self] _ in
                    guard let x = self?.logHeadView.frame.origin.x, let y = self?.logHeadView.frame.origin.y else {return}
                    LogsSettings.shared.logHeadFrameX = Float(x)
                    LogsSettings.shared.logHeadFrameY = Float(y)
                })
        }
    }

    func shouldReceive(point: CGPoint) -> Bool {
        if Dotzu.sharedManager.displayedList {
            return true
        }
        return self.logHeadView.frame.contains(point)
    }
}

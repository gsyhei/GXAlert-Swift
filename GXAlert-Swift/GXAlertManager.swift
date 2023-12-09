//
//  GXAlertManager.swift
//  GXAlertSample
//
//  Created by Gin on 2020/11/17.
//

import UIKit

fileprivate let GX_ALERT_ANIMATION_DURATION: TimeInterval = 0.5
fileprivate let GX_ALERT_USINGSPRING_DAMPING: CGFloat = 0.7
fileprivate let GX_ALERT_USINGSPRING_VELOCITY: CGFloat = 1.0

public class GXAlertManager: NSObject {
    weak var superview: UIView?
    weak var alertView: UIView?
    var style: GXAlertStyle!
    var usingSpring: Bool = true
    var backgoundTapDismissEnable: Bool = true
    var tapBlock: (() -> Void)?
    var dismissBlock: (() -> Void)?

    lazy var backgroundView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.alpha = 0.0
        view.backgroundColor = UIColor.black
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer(_:)))
        view.addGestureRecognizer(tap)

        return view
    }()

    required init(superview: UIView?, alertView: UIView, style: GXAlertStyle) {
        super.init()
        self.superview = superview
        self.alertView = alertView
        self.style = style

        if self.superview == nil {
            self.superview = UIApplication.shared.windows.first
            if self.superview == nil {
                self.superview = UIApplication.shared.delegate?.window as? UIView
            }
        }
        guard self.superview != nil else { fatalError("GXAlert superview is nil.") }
        self.backgroundView.frame = self.superview!.bounds
        self.superview?.addSubview(self.backgroundView)

        guard let letAlert = self.alertView else { return }

        self.superview?.addSubview(letAlert)
        switch self.style {
        case .alert:
            letAlert.alpha = 0.0
            letAlert.center = self.backgroundView.center
            letAlert.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

        case .sheetTop:
            var frame = letAlert.frame
            frame.origin.y = -letAlert.frame.height
            frame.size.width = self.backgroundView.frame.width
            letAlert.frame = frame

        case .sheetLeft:
            var frame = letAlert.frame
            frame.origin.x = -letAlert.frame.width
            frame.size.height = self.backgroundView.frame.height
            letAlert.frame = frame

        case .sheetRight:
            var frame = letAlert.frame
            frame.origin.x = self.backgroundView.frame.width
            frame.size.height = self.backgroundView.frame.height
            letAlert.frame = frame

        case .sheetBottom:
            var frame = letAlert.frame
            frame.origin.y = self.backgroundView.frame.height
            frame.size.width = self.backgroundView.frame.width
            letAlert.frame = frame

        default: break
        }
    }

    func show() {
        guard let letAlert = self.alertView else { return }

        var frame = letAlert.frame
        switch self.style {
        case .sheetTop:
            frame.origin.y = 0.0
        case .sheetLeft:
            frame.origin.x = 0.0
        case .sheetRight:
            frame.origin.x = self.backgroundView.frame.width - letAlert.frame.width
        case .sheetBottom:
            frame.origin.y = self.backgroundView.frame.height - letAlert.frame.height
        default: break
        }
        GXAlertManager.gx_animate(withUsingSpring: self.usingSpring, animations: {
            self.backgroundView.alpha = 0.4
            if (self.style == .alert) {
                self.alertView?.transform = .identity
                self.alertView?.alpha = 1.0
            }
            else {
                self.alertView?.frame = frame
            }
        }, completion: nil)
    }

    func hide(animated: Bool = true) {
        guard self.superview != nil else { return }
        guard let letAlert = self.alertView else { return }

        if animated {
            var frame = letAlert.frame
            switch self.style {
            case .sheetTop:
                frame.origin.y = -letAlert.frame.height
            case .sheetLeft:
                frame.origin.x = -letAlert.frame.width
            case .sheetRight:
                frame.origin.x = self.backgroundView.frame.width
            case .sheetBottom:
                frame.origin.y = self.backgroundView.frame.height
            default: break
            }
            GXAlertManager.gx_animate(withUsingSpring: self.usingSpring, animations: {
                self.backgroundView.alpha = 0.0
                if (self.style == .alert) {
                    self.alertView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    self.alertView?.alpha = 0.0
                }
                else {
                    self.alertView?.frame = frame
                }
            }) { (finished) in
                self.backgroundView.removeFromSuperview()
                self.alertView?.removeFromSuperview()
            }
        }
        else {
            self.backgroundView.removeFromSuperview()
            self.alertView?.removeFromSuperview()
        }
        if self.dismissBlock != nil {
            self.dismissBlock!()
        }
    }

}

public extension GXAlertManager {

    enum GXAlertStyle: Int {
        case alert       = 0
        case sheetTop    = 1
        case sheetLeft   = 2
        case sheetRight  = 3
        case sheetBottom = 4
    }

    @objc func tapGestureRecognizer(_ tap: UITapGestureRecognizer) {
        if (self.backgoundTapDismissEnable) {
            self.hide()
            if (self.tapBlock != nil) {
                self.tapBlock!()
            }
        }
    }

    class func gx_animate(withUsingSpring usingSpring: Bool = false, animations: @escaping (() -> Void), completion: ((Bool) -> Void)?) {
        if usingSpring {
            UIView.animate(withDuration: GX_ALERT_ANIMATION_DURATION,
                           delay: 0,
                           usingSpringWithDamping: GX_ALERT_USINGSPRING_DAMPING,
                           initialSpringVelocity: GX_ALERT_USINGSPRING_VELOCITY,
                           options: .curveEaseInOut,
                           animations: animations, completion: completion)
        }
        else {
            UIView.animate(withDuration: GX_ALERT_ANIMATION_DURATION/2, animations: animations, completion: completion)
        }
    }

}

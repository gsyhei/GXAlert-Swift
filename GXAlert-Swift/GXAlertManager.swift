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
    var alertView: UIView!
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
        self.superview?.addSubview(self.alertView)
        
        switch self.style {
        case .alert:
            self.alertView.alpha = 0.0
            self.alertView.center = self.backgroundView.center
            self.alertView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        case .sheetTop:
            var frame = self.alertView.frame
            frame.origin.y = -self.alertView.frame.height
            frame.size.width = self.backgroundView.frame.width
            self.alertView.frame = frame
            
        case .sheetLeft:
            var frame = self.alertView.frame
            frame.origin.x = -self.alertView.frame.width
            frame.size.height = self.backgroundView.frame.height
            self.alertView.frame = frame
            
        case .sheetRight:
            var frame = self.alertView.frame
            frame.origin.x = self.backgroundView.frame.width
            frame.size.height = self.backgroundView.frame.height
            self.alertView.frame = frame
            
        case .sheetBottom:
            var frame = self.alertView.frame
            frame.origin.y = self.backgroundView.frame.height
            frame.size.width = self.backgroundView.frame.width
            self.alertView.frame = frame
            
        default: break
        }
    }
    
    func show() {
        var frame = self.alertView.frame
        switch self.style {
        case .sheetTop:
            frame.origin.y = 0.0
        case .sheetLeft:
            frame.origin.x = 0.0
        case .sheetRight:
            frame.origin.x = self.backgroundView.frame.width - self.alertView.frame.width
        case .sheetBottom:
            frame.origin.y = self.backgroundView.frame.height - self.alertView.frame.height
        default: break
        }
        GXAlertManager.gx_animate(withUsingSpring: self.usingSpring, animations: {
            self.backgroundView.alpha = 0.4
            if (self.style == .alert) {
                self.alertView.transform = .identity
                self.alertView.alpha = 1.0
            }
            else {
                self.alertView.frame = frame
            }
        }, completion: nil)
    }
    
    func hide(animated: Bool = true) {
        guard self.superview != nil else { return }
        if animated {
            var frame = self.alertView.frame
            switch self.style {
            case .sheetTop:
                frame.origin.y = -self.alertView.frame.height
            case .sheetLeft:
                frame.origin.x = -self.alertView.frame.width
            case .sheetRight:
                frame.origin.x = self.backgroundView.frame.width
            case .sheetBottom:
                frame.origin.y = self.backgroundView.frame.height
            default: break
            }
            GXAlertManager.gx_animate(withUsingSpring: self.usingSpring, animations: {
                self.backgroundView.alpha = 0.0
                if (self.style == .alert) {
                    self.alertView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    self.alertView.alpha = 0.0
                }
                else {
                    self.alertView.frame = frame
                }
            }) { (finished) in
                self.backgroundView.removeFromSuperview()
                self.alertView.removeFromSuperview()
            }
        }
        else {
            self.backgroundView.removeFromSuperview()
            self.alertView.removeFromSuperview()
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

//
//  UIView+GXAlert.swift
//  GXAlertSample
//
//  Created by Gin on 2020/11/17.
//

import UIKit

private var GX_MANAGER = 0
public extension UIView {
    
    /// alert管理器
    var gx_manager: GXAlertManager? {
        get {
            return objc_getAssociatedObject(self, &GX_MANAGER) as? GXAlertManager
        }
        set {
            objc_setAssociatedObject(self, &GX_MANAGER, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Class methods
    
    class func alertForView(from view: UIView) -> UIView? {
        for subview in view.subviews {
            if subview.isKind(of: self) {
                return subview
            }
        }
        return nil
    }
    
    class func hideAlertForView(from view: UIView, animated: Bool = true) -> Bool {
        if let hud = self.alertForView(from: view) {
            hud.hide(animated: animated)
            return true
        }
        return false
    }
    
    // MARK: - Utility
    
    func show(to view: UIView? = nil,
              style: GXAlertManager.GXAlertStyle,
              backgoundTapDismissEnable: Bool = true,
              usingSpring: Bool = true,
              tapBlock: (() -> Void)? = nil,
              dismissBlock: (() -> Void)? = nil)
    {
        let manager = GXAlertManager(superview: view, alertView: self, style: style)
        manager.backgoundTapDismissEnable = backgoundTapDismissEnable;
        manager.usingSpring = usingSpring
        manager.tapBlock = tapBlock
        manager.dismissBlock = dismissBlock
        manager.show()
        self.gx_manager = manager
    }
    
    func hide(animated: Bool = true) {
        if self.gx_manager != nil {
            self.gx_manager?.hide(animated: animated)
        }
    }
}

//
//  UIView+Extension.swift
//  takeaway
//
//  Created by jike on 2018/1/24.
//  Copyright © 2018年 zaihui. All rights reserved.
//

import UIKit

// MARK: BasicAnimation
extension UIView {
    
    func rotationAnimation(with duration: Double = 2) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.repeatCount = MAXFLOAT
        rotationAnimation.isCumulative = true
        rotationAnimation.duration = duration
        rotationAnimation.isRemovedOnCompletion = false
        
       layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func stopRotationAnimation() {
        layer.removeAnimation(forKey: "rotationAnimation")
    }
}
// MARK: - Extension animate

extension UIView {
    func animate(hide: Bool, completion: (() -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        if hide {
                            self.alpha = 0
                        } else {
                            self.alpha = 1
                        }
        }) { _ in
            completion?()
        }
    }
}

// MARK: - Extension addConstraint

extension UIView {
    
    func addConstraint(width: CGFloat, height: CGFloat) {
        if width > 0 {
            addConstraint(NSLayoutConstraint(item: self,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: NSLayoutConstraint.Attribute(rawValue: 0)!,
                                             multiplier: 1,
                                             constant: width))
        }
        if height > 0 {
            addConstraint(NSLayoutConstraint(item: self,
                                             attribute: .height,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: NSLayoutConstraint.Attribute(rawValue: 0)!,
                                             multiplier: 1,
                                             constant: height))
        }
    }
    
    func addConstraint(toCenterX xView: UIView?, toCenterY yView: UIView?) {
        addConstraint(toCenterX: xView, constantX: 0, toCenterY: yView, constantY: 0)
    }
    
    func addConstraint(toCenterX xView: UIView?,
                       constantX: CGFloat,
                       toCenterY yView: UIView?,
                       constantY: CGFloat) {
        if let xView = xView {
            addConstraint(NSLayoutConstraint(item: xView,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .centerX,
                                             multiplier: 1, constant: constantX))
        }
        if let yView = yView {
            addConstraint(NSLayoutConstraint(item: yView,
                                             attribute: .centerY,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .centerY,
                                             multiplier: 1,
                                             constant: constantY))
        }
    }
    
    func addConstraint(to view: UIView, edgeInset: UIEdgeInsets) {
        addConstraint(with: view,
                      topView: self,
                      leftView: self,
                      bottomView: self,
                      rightView: self,
                      edgeInset: edgeInset)
    }
    
    func addConstraint(with view: UIView,
                       topView: UIView?,
                       leftView: UIView?,
                       bottomView: UIView?,
                       rightView: UIView?,
                       edgeInset: UIEdgeInsets) {
        if let topView = topView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .top,
                                             relatedBy: .equal,
                                             toItem: topView,
                                             attribute: .top,
                                             multiplier: 1,
                                             constant: edgeInset.top))
        }
        if let leftView = leftView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .left,
                                             relatedBy: .equal,
                                             toItem: leftView,
                                             attribute: .left,
                                             multiplier: 1,
                                             constant: edgeInset.left))
        }
        if let bottomView = bottomView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: bottomView,
                                             attribute: .bottom,
                                             multiplier: 1,
                                             constant: edgeInset.bottom))
        }
        if let rightView = rightView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .right,
                                             relatedBy: .equal,
                                             toItem: rightView,
                                             attribute: .right,
                                             multiplier: 1,
                                             constant: edgeInset.right))
        }
    }
}

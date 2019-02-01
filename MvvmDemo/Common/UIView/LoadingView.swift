//
//  LoadingView.swift
//  takeaway
//
//  Created by 徐强强 on 2018/7/3.
//  Copyright © 2018年 zaihui. All rights reserved.
//

import UIKit

private let padding: CGFloat = 14
private let cornerRadius: CGFloat = 12
private let loadingWidthHeight: CGFloat = 37
private let textFont = UIFont.systemFont(ofSize: 14)
private let hudOffset = CGPoint(x: 0, y: -50)
private let JIdentifier = "JScreenView"

public class LoadingView: UIView {

    private var activityView: UIActivityIndicatorView?
    private var text: String?
    private var hudWidth: CGFloat = 110
    private var hudHeight: CGFloat = 110
    private let textHudWidth: CGFloat = 130
    
    // MARK: - init
    
    // enable ：是否允许用户交互，默认允许。
    init(text: String?,
         enable: Bool = true,
         offset: CGPoint = hudOffset,
         superView: UIView) {
        self.text = text
        
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: hudWidth, height: hudHeight)))
        setupUI()
        addLoadingView(offset: offset, superView: superView)
        
        if !enable {
            superView.addSubview(screenView)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.layer.cornerRadius = cornerRadius
        addActivityView()
        addLabel()
    }
    
    private func addLoadingView(offset: CGPoint, superView: UIView) {
        guard self.superview == nil else {
            return
        }
        
        superView.addSubview(self)
        self.alpha = 0
        
        if text != nil {
            hudWidth = textHudWidth
        }
        addConstraint(width: hudWidth, height: hudHeight)
        superView.addConstraint(toCenterX: self,
                                constantX: offset.x,
                                toCenterY: self,
                                constantY: offset.y)
    }
    
    private func addLabel() {
        
        var labelY: CGFloat = 0.0
        labelY = padding * 2 + loadingWidthHeight
        
        if let text = text {
            textLabel.text = text
            addSubview(textLabel)
            
            addConstraint(to: textLabel, edgeInset: UIEdgeInsets(top: labelY,
                                                                 left: padding / 2,
                                                                 bottom: -padding,
                                                                 right: -padding / 2))
            let textSize: CGSize = size(from: text)
            hudHeight = textSize.height + labelY + padding
        }
    }
    
    private func addActivityView() {
        activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView?.translatesAutoresizingMaskIntoConstraints = false
        activityView?.startAnimating()
        addSubview(activityView!)
        
        generalConstraint(at: activityView!)
    }
    
    // MARK: - show func
    
    public func show() {
        self.animate(hide: false) {
        }
    }
    
    static func show(text: String?,
                     enable: Bool = false,
                     offset: CGPoint = hudOffset,
                     superView: UIView) {
        let loading = LoadingView(text: text,
                                  enable: enable,
                                  offset: offset,
                                  superView: superView)
        loading.show()
    }
    
    // MARK: - Hide func
    
    public func hide() {
        self.animate(hide: true) {
            self.removeFromSuperview()
            self.screenView.removeFromSuperview()
        }
    }
    
    static func hide(from superView: UIView) {
        for view in superView.subviews {
            if view.isKind(of: self) {
                view.animate(hide: true, completion: {
                    view.removeFromSuperview()
                })
            }
            if view.restorationIdentifier == JIdentifier {
                view.removeFromSuperview()
            }
        }
    }
    
    // MARK: - method
    
    private func size(from text: String) -> CGSize {
        return text.textSizeWithFont(font: textFont, constrainedToSize: CGSize(width: hudWidth - padding, height: CGFloat(MAXFLOAT)))
    }
    
    private func generalConstraint(at view: UIView) {
        
        view.addConstraint(width: loadingWidthHeight, height: loadingWidthHeight)
        if text != nil {
            addConstraint(toCenterX: view, toCenterY: nil)
            addConstraint(with: view,
                          topView: self,
                          leftView: nil,
                          bottomView: nil,
                          rightView: nil,
                          edgeInset: UIEdgeInsets(top: padding, left: 0, bottom: 0, right: 0))
        } else {
            addConstraint(toCenterX: view, toCenterY: view)
        }
    }
    
    // MARK: - setter && getter
    
    private lazy var screenView: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        view.isUserInteractionEnabled = true
        view.restorationIdentifier = JIdentifier
        
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = textFont
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
}

// MARK: - Extension String

extension String {
    
    fileprivate func textSizeWithFont(font: UIFont, constrainedToSize size: CGSize) -> CGSize {
        var textSize: CGSize!
        if size.equalTo(CGSize.zero) {
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            textSize = self.size(withAttributes: attributes as? [NSAttributedString.Key: Any])
        } else {
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            
            let stringRect = self.boundingRect(with: size,
                                               options: option,
                                               attributes: attributes as? [NSAttributedString.Key: Any],
                                               context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}

// MARK: - Extension LoadingView

extension LoadingView {
    
    fileprivate class func asyncAfter(duration: TimeInterval, completion: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion?()
        }
    }
}

//
//  UIButton+Extension.swift
//  MvvmDemo
//
//  Created by 徐强强 on 2019/2/1.
//  Copyright © 2019年 徐强强. All rights reserved.
//

import UIKit

// MARK: - UIButton布局样式

/// UIButton布局样式
///
/// - top: image在上，label在下
/// - left: image在左，label在右
/// - bottom: image在下，label在上
/// - right: image在右，label在左

enum ButtonEdgeInsetsStyle {
    case top
    case left
    case bottom
    case right
}

extension UIButton {
    
    func layoutButton(edgeInsetsStyle style: ButtonEdgeInsetsStyle, imageTitleSpace space: CGFloat, isUsingLabelFrameWidth: Bool = false) {
        let imageWidth = imageView?.intrinsicContentSize.width ?? 0
        let imageHeight = imageView?.intrinsicContentSize.height ?? 0
        let labelWidth = isUsingLabelFrameWidth ? (titleLabel?.frame.width ?? 0) : (titleLabel?.intrinsicContentSize.width ?? 0)
        let labelHeight = titleLabel?.intrinsicContentSize.height ?? 0
        
        let imageOffsetX = labelWidth / 2 //image中心移动的x距离
        let imageOffsetY = imageHeight / 2 + space / 2 //image中心移动的y距离
        let labelOffsetX = imageWidth / 2 //label中心移动的x距离
        let labelOffsetY = labelHeight / 2 + space / 2 //label中心移动的y距离
        
        let tempWidth = labelWidth > imageWidth ? labelWidth : imageWidth
        let changedWidth = labelWidth + imageWidth - tempWidth
        let tempHeight = labelHeight > imageHeight ? labelHeight : imageHeight
        let changedHeight = labelHeight + imageHeight + space - tempHeight
        
        var newImageEdgeInsets = UIEdgeInsets.zero
        var newTitleEdgeInsets = UIEdgeInsets.zero
        
        switch style {
        case .top:
            newImageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            newTitleEdgeInsets = UIEdgeInsets(top: labelOffsetY, left: -labelOffsetX, bottom: -labelOffsetY, right: labelOffsetX)
            self.contentEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: -changedWidth / 2, bottom: changedHeight - imageOffsetY, right: -changedWidth / 2)
        case .left:
            newImageEdgeInsets = UIEdgeInsets(top: 0, left: -space / 2, bottom: 0, right: space / 2)
            newTitleEdgeInsets = UIEdgeInsets(top: 0, left: space / 2, bottom: 0, right: -space / 2)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: space / 2, bottom: 0, right: space / 2)
        case .bottom:
            newImageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            newTitleEdgeInsets = UIEdgeInsets(top: -labelOffsetY, left: -labelOffsetX, bottom: labelOffsetY, right: labelOffsetX)
            self.contentEdgeInsets = UIEdgeInsets(top: changedHeight - imageOffsetY, left: -changedWidth / 2, bottom: imageOffsetY, right: -changedWidth / 2)
        case .right:
            newImageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space / 2, bottom: 0, right: -labelWidth - space / 2.0)
            newTitleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space / 2.0, bottom: 0, right: imageWidth + space / 2.0)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: space / 2, bottom: 0, right: space / 2)
        }
        
        imageEdgeInsets = newImageEdgeInsets
        titleEdgeInsets = newTitleEdgeInsets
        
    }
}

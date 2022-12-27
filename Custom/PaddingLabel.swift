//
//  PaddingLabel.swift
//  Pods
//
//  Created by SangWoo's MacBook on 2022/12/27.
//
import UIKit

//양 옆 패딩(마진)설정이 가능한 커스텀 레이블
class PaddingLabel: UILabel {
    var top: CGFloat = 0
    var bottom: CGFloat = 0
    var left: CGFloat = 0
    var right: CGFloat = 0
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.top = padding.top
        self.left = padding.left
        self.bottom = padding.bottom
        self.right = padding.right
    }
    
//    override func drawText(in rect: CGRect) {
//        let padding = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right)
//        super.drawText(in: rect.inset(dx: 1, dy: 1))
//    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += self.left + self.right
        contentSize.height += self.top + self.bottom
        
        return contentSize
    }
}

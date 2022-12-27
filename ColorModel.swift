//
//  ColorModel.swift
//  Pods
//
//  Created by SangWoo's MacBook on 2022/12/27.
//

import Foundation

struct RGB {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
    
    var uiColor: UIColor {
        return UIColor(red: self.red, green: self.green, blue: self.blue, alpha: self.alpha)
    }
    
    var cgColor: CGColor {
        return uiColor.cgColor
    }
}

struct HSV {
    var hue: CGFloat
    var saturation: CGFloat
    var value: CGFloat
    var alpha: CGFloat
}

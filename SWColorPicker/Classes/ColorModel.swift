//
//  ColorModel.swift
//  Pods
//
//  Created by SangWoo's MacBook on 2022/12/27.
//

import UIKit

public struct RGB {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat

    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    init(color: UIColor) {
        self.init(red: color.ciColor.red,
                  green: color.ciColor.green,
                  blue: color.ciColor.blue,
                  alpha: color.ciColor.alpha)
    }
    
    var uiColor: UIColor {
        return UIColor(red: self.red, green: self.green, blue: self.blue, alpha: self.alpha)
    }

    var cgColor: CGColor {
        return uiColor.cgColor
    }
    
    var hexCode: String {
        let hsv = rgbToHSV(self)
        return hsvToHex(hsv)
    }
}

public struct HSV {
    var hue: CGFloat
    var saturation: CGFloat
    var value: CGFloat
    var alpha: CGFloat

    var uiColor: UIColor {
        return UIColor(hue: self.hue, saturation: self.saturation, brightness: self.value, alpha: self.alpha)
    }
    
    public init(hue: CGFloat, saturation: CGFloat, value: CGFloat, alpha: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.value = value
        self.alpha = alpha
    }

    var cgColor: CGColor {
        return self.uiColor.cgColor
    }
    
    var hexCode: String {
        return hsvToHex(self)
    }
}

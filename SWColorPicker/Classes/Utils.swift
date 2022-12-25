//
//  Utils.swift
//  SWColorPicker
//
//  Created by SangWoo's MacBook on 2022/12/25.
//

import Foundation

typealias RGB = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

typealias HSV = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)

func hsvToRGB(_ hsv: HSV) -> RGB {
    var r,g,b: CGFloat
    let hue = Int(hsv.hue * 6)
    let c = hsv.brightness * hsv.saturation
    let m = hsv.brightness - c
    let a = ((hsv.hue*360)/60).truncatingRemainder(dividingBy: 2)
    let x = c * ( 1 -  abs(a - 1) )
    
    switch hue {
    case 0: r = c; g = x; b = 0; break;
    case 1: r = x; g = c; b = 0; break;
    case 2: r = 0; g = c; b = x; break;
    case 3: r = 0; g = x; b = c; break;
    case 4: r = x; g = 0; b = c; break;
    case 5: r = c; g = 0; b = x; break;
    default: r = c; g = x; b = 0; break;
    }
    
    return (red: r + m, green: g + m, blue: b + m, alpha: hsv.alpha)
}

func rgbToHSV(_ rgb: RGB) -> HSV {
    let maxValue: CGFloat = max(rgb.red, rgb.green, rgb.blue)
    let minValue: CGFloat = min(rgb.red, rgb.green, rgb.blue)
    let delta = maxValue - minValue
    let saturation: CGFloat = maxValue == 0 ? 0 : delta / minValue
    var hue: CGFloat = 0
    if delta == 0 {
        hue = 0
    } else {
        switch maxValue {
        case rgb.red: hue = (rgb.green - rgb.blue) / delta + (rgb.green < rgb.blue ? 6 : 0)
        case rgb.green: hue = (rgb.blue - rgb.red) / delta + 2
        default: hue = (rgb.red - rgb.green) / delta + 4
        }
        hue /= 6
    }
    
    return (hue: hue, saturation: saturation, brightness: maxValue, alpha: rgb.alpha)
}

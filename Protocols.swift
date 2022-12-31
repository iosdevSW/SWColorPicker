//
//  Protocols.swift
//  Pods
//
//  Created by SangWoo's MacBook on 2022/12/27.
//

import Foundation

protocol ColorWheelViewDelegate: AnyObject {
    func selectedColor(_ color: HSV)
}

protocol BrightnessViewDelegate: AnyObject {
    func changedBrightness(_ value: CGFloat)
}

protocol SWColorPickerViewDelegate: AnyObject {
    func selectedColor(_ color: UIColor)
}

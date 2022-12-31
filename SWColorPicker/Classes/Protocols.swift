//
//  Protocols.swift
//  Pods
//
//  Created by SangWoo's MacBook on 2022/12/27.
//

import Foundation

public protocol ColorWheelViewDelegate: AnyObject {
    func selectedColor(_ color: HSV)
}

public protocol BrightnessViewDelegate: AnyObject {
    func changedBrightness(_ value: CGFloat)
}

public protocol SWColorPickerViewDelegate: AnyObject {
    func selectedColor(_ color: UIColor)
    func cancel()
}

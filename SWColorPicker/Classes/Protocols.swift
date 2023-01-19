//
//  Protocols.swift
//  Pods
//
//  Created by SangWoo's MacBook on 2022/12/27.
//

import Foundation

public protocol ColorWheelViewDelegate: AnyObject {
    func didSelectColor(_ color: HSV)
}

public protocol BrightnessViewDelegate: AnyObject {
    func didChangeBrightness(_ value: CGFloat)
}

public protocol SWColorPickerViewDelegate: AnyObject {
    func didSelectColor(_ color: UIColor)
    func cancel()
}

//MARK: - Optional
public extension SWColorPickerViewDelegate {
    func cancel() { }
}

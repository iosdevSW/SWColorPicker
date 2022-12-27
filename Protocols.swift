//
//  Protocols.swift
//  Pods
//
//  Created by SangWoo's MacBook on 2022/12/27.
//

import Foundation

protocol ColorWheelDelegate: AnyObject {
    func selectedColor(_ color: RGB)
}

protocol SWColorPickerViewDelegate: AnyObject {
    func selectedColor(_ color: UIColor)
}

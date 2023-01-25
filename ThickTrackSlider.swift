//
//  ThickTrackSlider.swift
//  SWColorPicker
//
//  Created by 신상우 on 2023/01/24.
//

import UIKit

class ThickTrackSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 9, width: bounds.width, height: bounds.height-18)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

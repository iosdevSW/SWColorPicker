//
//  BrightnessView.swift
//  Pods
//
//  Created by SangWoo's MacBook on 2022/12/30.
//

import UIKit

public class BrightnessView: UIView {
    //MARK: - Properties
    weak var delegate: BrightnessViewDelegate?
    
    var selectedColor: HSV {
        didSet {
            self.selectedColor.value = 1
            self.barLayer.colors = [self.selectedColor.cgColor, UIColor.black.cgColor]
        }
    }
    
    private lazy var barLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [self.selectedColor.cgColor,
                        UIColor.black.cgColor]
        layer.locations = [0.0,1.0]
        layer.cornerRadius = 10
        layer.startPoint = .init(x: 0.0, y: 0.0)
        layer.endPoint = .init(x: 0.0, y: 1.0)
        
        return layer
    }()
    
    private let pointLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.lightGray.cgColor
        
        return layer
    }()
    
    //MARK: - Init
    init(frame: CGRect, color: HSV) {
        self.selectedColor = color
        super.init(frame: frame)
        self.layer.addSublayer(barLayer)
        self.layer.addSublayer(pointLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        self.barLayer.frame = rect
        self.resetPointLayer()
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        var newY = 0.0
        
        if point.y > self.frame.height-10 {
            newY = self.frame.height-10
        } else if point.y <= 0 {
            newY = 0
        } else {
            newY = point.y
        }
        let value = (self.frame.height-10.0 - newY) / (self.frame.height-10.0)
        delegate?.changedBrightness(value)
        
        self.pointLayer.path = UIBezierPath(roundedRect: .init(x: 0, y: newY, width: self.frame.width, height: 10), cornerRadius: 2).cgPath
    }
    
    func resetPointLayer() {
        self.pointLayer.path = UIBezierPath(roundedRect: .init(x: 0, y: 0, width: self.frame.width, height: 10), cornerRadius: 2).cgPath
    }
}

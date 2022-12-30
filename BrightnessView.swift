//
//  BrightnessView.swift
//  Pods
//
//  Created by SangWoo's MacBook on 2022/12/30.
//

import UIKit

public class BrightnessView: UIView {
    //MARK: - Properties
    private var barLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.red.cgColor,
                        UIColor.blue.cgColor]
        layer.locations = [0.0,1.0]
        layer.cornerRadius = 10
        layer.startPoint = .init(x: 0.0, y: 0.0)
        layer.endPoint = .init(x: 0.0, y: 1.0)
        
        return layer
    }()
    
    private let pointLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.backgroundColor = UIColor.lightGray.cgColor
        
        return layer
    }()
    
    //MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        self.layer.addSublayer(barLayer)
        self.layer.addSublayer(pointLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        self.barLayer.frame = rect
        self.pointLayer.path = UIBezierPath(roundedRect: .init(x: 0, y: 0, width: self.frame.width, height: 20), cornerRadius: 4).cgPath
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        print(point)
        self.pointLayer.path = UIBezierPath(roundedRect: .init(x: 0, y: point.y, width: self.frame.width, height: 20), cornerRadius: 4).cgPath
    }
    
}

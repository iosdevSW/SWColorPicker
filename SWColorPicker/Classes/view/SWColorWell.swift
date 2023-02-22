//
//  SWColorWell.swift
//  SWColorPicker
//
//  Created by 신상우 on 2023/02/08.
//

import UIKit

public class SWColorWell: UIView {
    private let colorView: ColorWheelView = {
        let view = ColorWheelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.addSubview(self.colorView)
        self.backgroundColor = .white
//        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func layout() {
//        NSLayoutConstraint.activate([
//            self.colorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            self.colorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            self.colorView.widthAnchor.constraint(equalToConstant: 30),
//            self.colorView.heightAnchor.constraint(equalToConstant: 30)
//        ])
//    }
    
}

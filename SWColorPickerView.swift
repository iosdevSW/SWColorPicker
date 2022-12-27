//
//  SWColorPickerView.swift
//  Pods
//
//  Created by SangWoo's MacBook on 2022/12/27.
//

import UIKit

public class SWColorPickerView: UIView {
    //MARK: - Propertie
    let colorWheel: ColorWheel = {
        let view = ColorWheel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let selectedColorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    //MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubView()
        self.layout()
        
        colorWheel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.addSubview(self.colorWheel)
        self.addSubview(self.selectedColorView)
    }
    
    
    //MARK: - Layout
    private func layout() {
        NSLayoutConstraint.activate([
            self.colorWheel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            self.colorWheel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            self.colorWheel.topAnchor.constraint(equalTo: self.topAnchor),
            self.colorWheel.heightAnchor.constraint(equalTo: self.colorWheel.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.selectedColorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.selectedColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 80),
            self.selectedColorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -80),
            self.selectedColorView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension SWColorPickerView: ColorWheelDelegate {
    func selectedColor(_ color: RGB) {
        self.selectedColorView.backgroundColor = color.uiColor
    }
}

//
//  SWColorPickerView.swift
//  Pods
//
//  Created by SangWoo's MacBook on 2022/12/27.
//

import UIKit

open class SWColorPickerView: UIView {
    //MARK: - Propertie
    private var selectedColor: UIColor = .white
    
    weak var delegate: SWColorPickerViewDelegate?
    
    private let colorWheel: ColorWheel = {
        let view = ColorWheel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let brightnessView: BrightnessView = {
        let view = BrightnessView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "color"
        label.font = UIFont(name: "Helvetica Neue", size: 16)
        label.textColor = .lightGray
        
        return label
    }()
    
    private let selectedColorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let doneButton: UIButton = {
        let btn = UIButton(type: .roundedRect)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .darkGray
        btn.backgroundColor = .darkGray
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("select", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        
        return btn
    }()
    
    //MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubView()
        self.layout()
        
        self.backgroundColor = .white
        
        colorWheel.delegate = self
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selector
    @objc private func didClickDoneBtn(_ button: UIButton) {
        self.delegate?.selectedColor(self.selectedColor)
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.addSubview(self.colorWheel)
        self.addSubview(self.brightnessView)
        self.addSubview(self.selectedColorView)
        self.addSubview(self.colorLabel)
        self.addSubview(self.doneButton)
    }
    
    //MARK: - Layout
    private func layout() {
        if self.frame.width > self.frame.height {
            NSLayoutConstraint.activate([
                self.colorWheel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                self.colorWheel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
                self.colorWheel.widthAnchor.constraint(equalTo: self.colorWheel.heightAnchor),
                self.colorWheel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40),
            ])
        } else {
            NSLayoutConstraint.activate([
                self.colorWheel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                self.colorWheel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
                self.colorWheel.heightAnchor.constraint(equalTo: self.colorWheel.widthAnchor),
                self.colorWheel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40),
            ])
        }
        
        NSLayoutConstraint.activate([
            self.brightnessView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.brightnessView.topAnchor.constraint(equalTo: self.colorWheel.topAnchor, constant: 20),
            self.brightnessView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            self.brightnessView.heightAnchor.constraint(equalTo: self.colorWheel.heightAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            self.colorLabel.centerXAnchor.constraint(equalTo: self.colorWheel.centerXAnchor),
            self.colorLabel.topAnchor.constraint(equalTo: self.colorWheel.bottomAnchor, constant:0),
        ])
        
        NSLayoutConstraint.activate([
            self.selectedColorView.topAnchor.constraint(equalTo: self.colorLabel.bottomAnchor, constant: 4),
            self.selectedColorView.centerXAnchor.constraint(equalTo: self.colorLabel.centerXAnchor),
            self.selectedColorView.widthAnchor.constraint(equalTo: self.colorWheel.widthAnchor, multiplier: 0.4),
            self.selectedColorView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            self.doneButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.doneButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.doneButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - AddTarget
    private func addTarget() {
        self.doneButton.addTarget(self, action: #selector(self.didClickDoneBtn(_:)), for: .touchUpInside)
    }
}

extension SWColorPickerView: ColorWheelDelegate {
    func selectedColor(_ color: RGB) {
        self.selectedColor = color.uiColor
        self.selectedColorView.backgroundColor = color.uiColor
    }
}

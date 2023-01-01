//
//  SWColorPickerView.swift
//  Pods
//
//  Created by SangWoo's MacBook on 2022/12/27.
//

import UIKit

public class SWColorPickerView: UIView {
    //MARK: - Propertie
    private var selectedColor: HSV = .init(hue: 1, saturation: 0, value: 1, alpha: 1)
    
    weak var delegate: SWColorPickerViewDelegate?
    
    private let colorWheelView: ColorWheelView = {
        let view = ColorWheelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var brightnessView: BrightnessView = {
        let view = BrightnessView(frame: .zero, color: self.selectedColor)
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
        view.layer.cornerRadius = 6
        
        return view
    }()
    
    private let sunImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "sun.max.fill")
        view.image = image
        view.tintColor = UIColor(red: 1.0, green: 0.83, blue: 0, alpha: 1.0)
        
        return view
    }()
    
    private let doneButton: UIButton = {
        let btn = UIButton(type: .roundedRect)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 4
        btn.setTitleColor(.darkGray, for: .normal)
        btn.setTitle("OK", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        
        return btn
    }()
    
    private let cancelButton: UIButton = {
        let btn = UIButton(type: .roundedRect)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 4
        btn.setTitleColor(.darkGray, for: .normal)
        btn.setTitle("CANCEL", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        
        return btn
    }()
    
    //MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubView()
        self.layout()
        
        self.backgroundColor = .white
        
        colorWheelView.delegate = self
        brightnessView.delegate = self
    }
    
    public init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        let rgb = RGB(red: color.ciColor.red,
                      green: color.ciColor.green,
                      blue: color.ciColor.blue,
                      alpha: color.ciColor.alpha)
        self.selectedColor = rgbToHSV(rgb)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selector
    @objc private func didClickDoneBtn(_ button: UIButton) {
        self.delegate?.selectedColor(self.selectedColor.uiColor)
    }
    
    @objc private func didClickCancelBtn(_ button: UIButton) {
        self.delegate?.cancel()
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.addSubview(self.colorWheelView)
        self.addSubview(self.brightnessView)
        self.addSubview(self.sunImageView)
        self.addSubview(self.selectedColorView)
        self.addSubview(self.colorLabel)
        self.addSubview(self.doneButton)
        self.addSubview(self.cancelButton)
    }
    
    //MARK: - Layout
    private func layout() {
        if self.frame.width > self.frame.height {
            NSLayoutConstraint.activate([
                self.colorWheelView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                self.colorWheelView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
                self.colorWheelView.widthAnchor.constraint(equalTo: self.colorWheelView.heightAnchor),
                self.colorWheelView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40),
            ])
        } else {
            NSLayoutConstraint.activate([
                self.colorWheelView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                self.colorWheelView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
                self.colorWheelView.heightAnchor.constraint(equalTo: self.colorWheelView.widthAnchor),
                self.colorWheelView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40),
            ])
        }
        
        NSLayoutConstraint.activate([
            self.brightnessView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.brightnessView.topAnchor.constraint(equalTo: self.colorWheelView.topAnchor, constant: 20),
            self.brightnessView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            self.brightnessView.heightAnchor.constraint(equalTo: self.colorWheelView.heightAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            self.sunImageView.centerXAnchor.constraint(equalTo: self.brightnessView.centerXAnchor),
            self.sunImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.06),
            self.sunImageView.heightAnchor.constraint(equalTo: self.sunImageView.widthAnchor),
            self.sunImageView.topAnchor.constraint(equalTo: self.brightnessView.bottomAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            self.colorLabel.centerXAnchor.constraint(equalTo: self.colorWheelView.centerXAnchor),
            self.colorLabel.topAnchor.constraint(equalTo: self.colorWheelView.bottomAnchor, constant: 14),
        ])
        
        NSLayoutConstraint.activate([
            self.selectedColorView.topAnchor.constraint(equalTo: self.colorLabel.bottomAnchor, constant: 4),
            self.selectedColorView.centerXAnchor.constraint(equalTo: self.colorLabel.centerXAnchor),
            self.selectedColorView.widthAnchor.constraint(equalTo: self.colorWheelView.widthAnchor, multiplier: 0.4),
            self.selectedColorView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            self.doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.doneButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.doneButton.heightAnchor.constraint(equalToConstant: 36),
            self.doneButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            self.cancelButton.trailingAnchor.constraint(equalTo: self.doneButton.leadingAnchor),
            self.cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 36),
            self.cancelButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    //MARK: - AddTarget
    private func addTarget() {
        self.doneButton.addTarget(self, action: #selector(self.didClickDoneBtn(_:)), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(self.didClickCancelBtn(_:)), for: .touchUpInside)
    }
}

extension SWColorPickerView: ColorWheelViewDelegate {
    public func selectedColor(_ color: HSV) {
        self.selectedColor = color
        self.selectedColorView.backgroundColor = color.uiColor
        self.brightnessView.resetPointLayer()
        self.brightnessView.selectedColor = color
    }
}

extension SWColorPickerView: BrightnessViewDelegate {
    public func changedBrightness(_ value: CGFloat) {
        self.selectedColor.value = value
        self.selectedColorView.backgroundColor = self.selectedColor.uiColor
    }
}

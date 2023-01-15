//
//  SWColorPickerViewController.swift
//  SWColorPicker
//
//  Created by 신상우 on 2023/01/14.
//

import UIKit

final public class SWColorPickerViewController: UIViewController {
    //MARK: - Properties
    private var selectedColor: HSV = .init(hue: 1, saturation: 0, value: 1, alpha: 1)
    
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
        view.layer.cornerRadius = 10
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = .zero
       
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
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.layout()
        self.view.backgroundColor = .white
        
        self.colorWheelView.delegate = self
        self.brightnessView.delegate = self
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.view.addSubview(self.colorWheelView)
        self.view.addSubview(self.colorLabel)
        self.view.addSubview(self.brightnessView)
        self.view.addSubview(self.sunImageView)
        self.view.addSubview(self.selectedColorView)
    }
    
    //MARK: - Layout
    private func layout() {
        NSLayoutConstraint.activate([
            self.colorWheelView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.colorWheelView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.76),
            self.colorWheelView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
            self.colorWheelView.heightAnchor.constraint(equalTo: self.colorWheelView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.brightnessView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.brightnessView.topAnchor.constraint(equalTo: self.colorWheelView.topAnchor, constant: 20),
            self.brightnessView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.065),
            self.brightnessView.heightAnchor.constraint(equalTo: self.colorWheelView.heightAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            self.sunImageView.centerXAnchor.constraint(equalTo: self.brightnessView.centerXAnchor),
            self.sunImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.06),
            self.sunImageView.heightAnchor.constraint(equalTo: self.sunImageView.widthAnchor),
            self.sunImageView.topAnchor.constraint(equalTo: self.brightnessView.bottomAnchor, constant: 6),
        ])
        
        NSLayoutConstraint.activate([
            self.colorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.colorLabel.topAnchor.constraint(equalTo: self.colorWheelView.bottomAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            self.selectedColorView.topAnchor.constraint(equalTo: self.colorLabel.bottomAnchor, constant: 4),
            self.selectedColorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.selectedColorView.widthAnchor.constraint(equalTo: self.colorWheelView.widthAnchor, multiplier: 0.4),
            self.selectedColorView.heightAnchor.constraint(equalTo: self.colorWheelView.widthAnchor, multiplier: 0.4)
        ])
    }
}

extension SWColorPickerViewController: ColorWheelViewDelegate, BrightnessViewDelegate {
    public func selectedColor(_ color: HSV) {
        self.selectedColor = color
        self.colorLabel.text = hsvToHex(color)
        self.brightnessView.resetPointLayer()
        self.brightnessView.selectedColor = color
        self.selectedColorView.backgroundColor = color.uiColor
    }
    
    public func changedBrightness(_ value: CGFloat) {
        self.selectedColor.value = value
        self.selectedColorView.backgroundColor = self.selectedColor.uiColor
        self.colorLabel.text = hsvToHex(self.selectedColor)
    }
}

//
//  ComponentView.swift
//  SWColorPicker
//
//  Created by SangWoo's MacBook on 2023/01/19.
//

import UIKit

final class ComponentView: UIView {
    let componentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    let colorSlider: ThickTrackSlider = {
        let slider = ThickTrackSlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubView()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.addSubview(self.componentLabel)
        self.addSubview(self.colorSlider)
    }
    
    //MARK: - Layout
    private func layout() {
        NSLayoutConstraint.activate([
            self.componentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.componentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.componentLabel.widthAnchor.constraint(equalToConstant: 46)
        ])
        
        NSLayoutConstraint.activate([
            self.colorSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.colorSlider.trailingAnchor.constraint(equalTo: self.componentLabel.leadingAnchor, constant: -10),
            self.colorSlider.centerYAnchor.constraint(equalTo: self.componentLabel.centerYAnchor),
//            self.colorSlider.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

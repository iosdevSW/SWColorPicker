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
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    let inputTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 0.8
        tf.layer.cornerRadius = 8
        tf.backgroundColor = .white
        tf.textColor = .black
        
        return tf
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
        self.addSubview(self.inputTextField)
    }
    
    //MARK: - Layout
    private func layout() {
        NSLayoutConstraint.activate([
            self.componentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.componentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.componentLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            self.inputTextField.leadingAnchor.constraint(equalTo: self.componentLabel.trailingAnchor, constant: 10),
            self.inputTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.inputTextField.centerYAnchor.constraint(equalTo: self.componentLabel.centerYAnchor)
        ])
    }
}

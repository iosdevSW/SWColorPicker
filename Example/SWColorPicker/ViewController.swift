//
//  ViewController.swift
//  SWColorPicker
//
//  Created by iosdev.sw on 01/01/2023.
//  Copyright (c) 2023 iosdev.sw. All rights reserved.
//

import UIKit
import SWColorPicker

class ViewController: UIViewController {
    let selectView = UIView()
    let colorPickerVC = SWColorPickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        selectView.translatesAutoresizingMaskIntoConstraints = false
        selectView.layer.cornerRadius = 8
        self.view.addSubview(self.selectView)
        
        NSLayoutConstraint.activate([
            selectView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            selectView.topAnchor.constraint(equalTo: self.view.topAnchor),
            selectView.widthAnchor.constraint(equalToConstant: 40),
            selectView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        colorPickerVC.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.present(colorPickerVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: SWColorPickerViewDelegate {
    func didSelectColor(_ color: UIColor) {
        self.selectView.backgroundColor = color
    }
}


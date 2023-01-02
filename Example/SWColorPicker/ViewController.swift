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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        let colorPicker = SWColorPickerView()
        self.view.addSubview(colorPicker)
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            colorPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            colorPicker.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            colorPicker.heightAnchor.constraint(equalToConstant: 400),
            colorPicker.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


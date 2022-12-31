//
//  ViewController.swift
//  SWColorPicker
//
//  Created by iosdev.sw on 12/25/2022.
//  Copyright (c) 2022 iosdev.sw. All rights reserved.
//

import UIKit
import SWColorPicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .lightGray
        let colorPicker = SWColorPickerView()
        self.view.addSubview(colorPicker)
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            colorPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            colorPicker.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            colorPicker.heightAnchor.constraint(equalToConstant: 320),
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


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
        let colorWheel = ColorWheel(frame: .init(x: 0, y: 0, width: 300, height: 300))
        self.view.addSubview(colorWheel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


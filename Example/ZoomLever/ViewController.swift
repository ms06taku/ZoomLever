//
//  ViewController.swift
//  ZoomLever
//
//  Created by Taku Himeno on 06/17/2017.
//  Copyright (c) 2017 Taku Himeno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var zoomLever: ZoomLever!
    @IBOutlet private weak var valueLabel: UILabel!{
        didSet{
            valueLabel.text = "0.0"
        }
    }
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


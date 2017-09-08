//
//  ViewController.swift
//  ZoomLever
//
//  Created by Taku Himeno on 06/17/2017.
//  Copyright (c) 2017 Taku Himeno. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ZoomLeverDelegate {
    
    @IBOutlet weak var zoomLever: ZoomLever!{
        didSet{
            zoomLever.delegate = self
        }
    }
    @IBOutlet private weak var rateLabel: UILabel!{
        didSet{
            rateLabel.text = "0.0"
        }
    }
    @IBOutlet private weak var valueLabel: UILabel!{
        didSet{
            valueLabel.text = "0.0"
        }
    }
    
    // MARK: - view
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - delegate
    
    func rateChanged(rate: CGFloat) {
        rateLabel.text = String(describing: rate)
    }
    
    func valueChanged(value: CGFloat) {
        valueLabel.text = String(describing: value)
    }
}


//
//  ViewController.swift
//  ZoomLever
//
//  Created by Taku Himeno on 06/17/2017.
//  Copyright (c) 2017 Taku Himeno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var measureView: UIView!
    @IBOutlet private weak var lever: UIView!
    @IBOutlet private weak var valueLabel: UILabel!{
        didSet{
            valueLabel.text = "0.0"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - TOUCH
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.06, animations: { () -> Void in
            self.lever.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }){ (Bool) -> Void in
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: measureView)
        let prevLocation = touches.first!.previousLocation(in: measureView)
        
        if location.x <= 0 {
            return
        }
        
        if measureView.frame.width < location.x {
            return
        }
        
        var frame: CGRect = lever.frame
        frame.origin.x += (location.x - prevLocation.x)
        lever.frame = frame
        
        let value = (lever.frame.origin.x + lever.frame.width) - measureView.frame.width / 2
        print(value)
        
        valueLabel.text = String(format: "%.1f", value)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.lever.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }){(Bool) -> Void in
            
        }
    }
}


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
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = (lever.frame.origin.x + lever.frame.width / 2) - measureView.frame.width / 2
        print(lever.center.x)
        print(measureView.center.x)
        print(value)
        
        valueLabel.text = String(format: "%.1f", value)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - TOUCH
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view {
                if touchedView != lever {
                    return
                }
            }
        }
        
        // lever transform
        UIView.animate(withDuration: 0.06, animations: { () -> Void in
            self.lever.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }){ (Bool) -> Void in
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view {
                if touchedView != lever {
                    return
                }
            }
        }
        
        let nextLocation = touches.first!.location(in: measureView)
        let prevLocation = touches.first!.previousLocation(in: measureView)
        
        label1.text = "location.x : " + String(describing: nextLocation.x)
        
        var frame: CGRect = lever.frame
        frame.origin.x += (nextLocation.x - prevLocation.x)
        
        if measureView.frame.width < (frame.origin.x + frame.width) {
            // over
            return
        }
        
        if frame.origin.x < 0 {
            // less
            return
        }
        
        lever.frame = frame
        
        let value = (lever.frame.origin.x + lever.frame.width / 2) - measureView.frame.width / 2
    
        valueLabel.text = String(format: "%.1f", value)
    
        label2.text = ("lever   center : " + String(describing: lever.center.x))
        label3.text = ("measure center : " + String(describing: measureView.frame.width / 2))
        label4.text = ("value          : " + String(describing: value))
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.lever.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }){(Bool) -> Void in
            
        }
    }
    
    // MARK: - METHODS
}


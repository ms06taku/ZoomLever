//
//  ZoomLever.swift
//  ZoomLever
//
//  Created by Taku HIMENO on 2017/09/08.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

protocol ZoomLeverDelegate: class {
    // rate (-1.0 ~ 1.0)
    func rateChanged(rate: CGFloat)
    func valueChanged(value: CGFloat)
}

class ZoomLever: UIView {
    private var contentView: UIView? = nil
    @IBOutlet var measureView: UIView!
    @IBOutlet private weak var leverView: UIView!
    var delegate: ZoomLeverDelegate? = nil
    var isPulling: Bool = false
    var rate: CGFloat = 0.0
    var value: CGFloat = 0.0
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
    }
    
    private func setupXib() {
        // load
        let nib = UINib(nibName: "ZoomLever", bundle: Bundle(for: type(of: self)))
        contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        guard let contentView = contentView else {
            return
        }
        
        // show
        contentView.frame = self.frame
        self.addSubview(contentView)
        
        // add constraints
        let layouts: [NSLayoutAttribute] = [.top, .bottom, .leading, .trailing]
        layouts.map {
            NSLayoutConstraint(item: self,
                               attribute: $0,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: $0,
                               multiplier: 1,
                               constant: 0)
        }.forEach{
            self.addConstraint($0)
        }
        
        // 引っ張っている最中、値に応じたvelocityでvalueを加算していく
        Timer.scheduledTimer(timeInterval: 0.1,
                             target: self,
                             selector: #selector(ZoomLever.calcValue),
                             userInfo: nil,
                             repeats: true)
        
        return
    }
    
    // MARK: - TOUCH
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view {
                if touchedView != leverView {
                    return
                }
            }
        }
        
        isPulling = true
        
        // lever transform
        UIView.animate(withDuration: 0.06, animations: { () -> Void in
            self.leverView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }){ (Bool) -> Void in
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view {
                if touchedView != leverView {
                    return
                }
            }
        }
        
        let nextLocation = touches.first!.location(in: measureView)
        let prevLocation = touches.first!.previousLocation(in: measureView)
        
        var frame: CGRect = leverView.frame
        frame.origin.x += (nextLocation.x - prevLocation.x)
        
        if measureView.frame.width < (frame.origin.x + frame.width) {
            // over
            return
        }
        
        if frame.origin.x < 0 {
            // less
            return
        }
        
        leverView.frame = frame
        let diff = (leverView.frame.origin.x + leverView.frame.width / 2) - measureView.frame.width / 2
        rate = diff / 100
        
        //self.delegate?.valueChanged(value: diff)
        self.delegate?.rateChanged(rate: rate)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        isPulling = false
        rate = 0
        self.delegate?.rateChanged(rate: rate)
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.leverView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            // 離したら0に戻す
            self.leverView.center = self.measureView.center
        }){(Bool) -> Void in
            
        }
    }
    
    // MARK: - TIMER METHODS
    
    func calcValue(){
        if isPulling{
            value += (1 * rate)
            self.delegate?.valueChanged(value: value)
        }
    }
}

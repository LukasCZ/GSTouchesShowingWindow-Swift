//
//  GSTouchesShowingController.swift
//  GSTouchesShowingWindow-Swift
//
//  Created by Lukas Petr on 8/25/17.
//  Copyright © 2017 Glimsoft. All rights reserved.
//

import UIKit

struct Constants {
    static let TouchImageName = "TouchImageBlue"
    static let ShortTapTresholdDuration = 0.11
    static let ShortTapInitialCircleRadius : CGFloat = 22.0
    static let ShortTapFinalCircleRadius : CGFloat = 57.0
}

class GSTouchesShowingController {
    
    let touchImageViewQueue = GSTouchImageViewQueue(touchesCount: 8)
    var touchImgViewsDict = Dictionary<String, UIImageView>()
    var touchesStartDateDict = Dictionary<String, NSDate>()
    
    public func touchBegan(_ touch: UITouch, view: UIView) -> Void {
        let touchImgView = self.touchImageViewQueue.popTouchImageView()
        touchImgView.center = touch.location(in: view)
        view.addSubview(touchImgView)
        
        touchImgView.alpha = 0.0
        touchImgView.transform = CGAffineTransform(scaleX: 1.13, y: 1.13)
        self.setTouchImageView(touchImgView, for: touch)
        
        UIView.animate(withDuration: 0.1) { 
            touchImgView.alpha = 1.0
            touchImgView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        self.touchesStartDateDict[String(format: "%p", touch)] = NSDate()
    }
    
    public func touchMoved(_ touch: UITouch, view: UIView) -> Void {
        self.touchImageView(for: touch)?.center = touch.location(in: view)
    }
    
    public func touchEnded(_ touch: UITouch, view: UIView) -> Void {
        guard let touchStartDate = self.touchesStartDateDict[String(format: "%p", touch)], let touchImgView = self.touchImageView(for: touch) else { return }
        let touchDuration = NSDate().timeIntervalSince(touchStartDate as Date)
        self.touchesStartDateDict.removeValue(forKey: String(format: "%p", touch))
        
        if touchDuration < Constants.ShortTapTresholdDuration {
            self.showExpandingCircle(at: touch.location(in: view), in: view)
        }
        
        UIView.animate(withDuration: 0.1, animations: { 
            touchImgView.alpha = 0.0
            touchImgView.transform = CGAffineTransform(scaleX: 1.13, y: 1.13)
        }) { (completed) in
            touchImgView.removeFromSuperview()
            touchImgView.alpha = 1.0
            self.touchImageViewQueue.push(touchImgView)
            self.removeTouchImageView(for: touch)
        }
    }
    
    func showExpandingCircle(at position: CGPoint, in view: UIView) -> Void {
        let circleLayer = CAShapeLayer()
        let initialRadius = Constants.ShortTapInitialCircleRadius
        let finalRadius = Constants.ShortTapFinalCircleRadius
        circleLayer.position = CGPoint(x: position.x - initialRadius, y: position.y - initialRadius)
        
        let startPathRect = CGRect(x: 0, y: 0, width: initialRadius * 2, height: initialRadius * 2)
        let startPath = UIBezierPath(roundedRect: startPathRect, cornerRadius: initialRadius)
        
        let endPathOrigin = initialRadius - finalRadius
        let endPathRect = CGRect(x: endPathOrigin, y: endPathOrigin, width: finalRadius * 2, height: finalRadius * 2)
        let endPath = UIBezierPath(roundedRect: endPathRect, cornerRadius: finalRadius)
        
        circleLayer.path = startPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor(red: 0.0/255, green: 135.0/255, blue: 244.0/255, alpha: 0.8).cgColor
        circleLayer.lineWidth = 2.0
        view.layer.addSublayer(circleLayer)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { 
            circleLayer.removeFromSuperlayer()
        }
        
        // Expanding animation
        let expandingAnimation = CABasicAnimation(keyPath: "path")
        expandingAnimation.fromValue = startPath.cgPath
        expandingAnimation.toValue = endPath.cgPath
        expandingAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        expandingAnimation.duration = 0.4
        expandingAnimation.repeatCount = 1.0
        circleLayer.add(expandingAnimation, forKey: "expandingAnimation")
        circleLayer.path = endPath.cgPath
        
        // Delayed fade out animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
            let fadingOutAnimation = CABasicAnimation(keyPath: "opacity")
            fadingOutAnimation.fromValue = 1.0
            fadingOutAnimation.toValue = 0.0
            fadingOutAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            fadingOutAnimation.duration = 0.15
            circleLayer.add(fadingOutAnimation, forKey: "fadeOutAnimation")
            circleLayer.opacity = 0.0
        }
        
        CATransaction.commit()
    }
    
    func touchImageView(for touch: UITouch) -> UIImageView? {
        return self.touchImgViewsDict[String(format: "%p", touch)]
    }
    
    func setTouchImageView(_ touchImageView: UIImageView, for touch: UITouch) {
        self.touchImgViewsDict[String(format: "%p", touch)] = touchImageView
    }
    
    func removeTouchImageView(for touch: UITouch) {
        self.touchImgViewsDict.removeValue(forKey: String(format: "%p", touch))
    }
}

class GSTouchImageViewQueue {
    
    var backingArray = Array<UIImageView>();
    
    convenience init(touchesCount: Int) {
        self.init()
        
        let bundle = Bundle(for: type(of: self))
        for _ in 0..<touchesCount {
            let imageView = UIImageView(image: UIImage(named: Constants.TouchImageName, in: bundle, compatibleWith: nil))
            self.backingArray.append(imageView)
        }
    }
    
    func popTouchImageView() -> UIImageView {
        return self.backingArray.removeFirst()
    }
    
    func push(_ touchImageView: UIImageView) -> Void {
        self.backingArray.append(touchImageView)
    }
}

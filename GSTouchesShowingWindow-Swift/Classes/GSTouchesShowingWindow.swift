//
//  GSTouchesShowingWindow.swift
//  GSTouchesShowingWindow-Swift
//
//  Created by Lukas Petr on 6/16/17.
//  Copyright © 2017 Glimsoft. All rights reserved.
//

import UIKit

public class GSTouchesShowingWindow: UIWindow {
    let controller = GSTouchesShowingController()
    
    override public func sendEvent(_ event: UIEvent) {
        if let touches = event.allTouches {
            for touch in touches {
                switch touch.phase {
                case .began:
                    self.controller.touchBegan(touch, view: self)
                    
                case .moved:
                    self.controller.touchMoved(touch, view: self)
                    
                case .ended, .cancelled:
                    self.controller.touchEnded(touch, view: self)
                    
                default:
                    break
                }
            }
        }
        super.sendEvent(event)
    }
}

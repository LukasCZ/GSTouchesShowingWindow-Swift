//
//  GSTouchesShowingWindow.swift
//  GSTouchesShowingWindow-Swift
//
//  Created by Lukas Petr on 6/16/17.
//  Copyright © 2017 Glimsoft. All rights reserved.
//

import UIKit

public struct TouchAppearance {
    var shortTapTresholdDuration = 0.11
    var shortTapInitialCircleRadius : CGFloat = 22.0
    var shortTapFinalCircleRadius : CGFloat = 57.0
    var touchColor = UIColor(red: 0.0/255, green: 135.0/255, blue: 244.0/255, alpha: 0.8)
}

public class GSTouchesShowingWindow: UIWindow {
  
  var showTouchesEnabled = false
  lazy var controller = GSTouchesShowingController()    // lets not consume any resources if not required
  
  var touchAppearance:TouchAppearance {
    get {
      return controller.appearance
    }
    set(appearance) {
      controller.appearance = appearance
    }
  }
    
    override public func sendEvent(_ event: UIEvent) {
      
      // if not showing touches, default to super behaviour
      guard self.showTouchesEnabled else {
        return super.sendEvent(event)
      }
      let touches = event.allTouches
      for touch in touches! {
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
      super.sendEvent(event)
    }
}

import UIKit
import ObjectiveC

extension UIWindow {
    static var touchesShowingControllerKey = 0;
    var controller: GSTouchesShowingController {
        get {
            var controller: GSTouchesShowingController? = objc_getAssociatedObject(self, &UIWindow.touchesShowingControllerKey) as? GSTouchesShowingController
            if controller == nil {
                controller = GSTouchesShowingController()
                objc_setAssociatedObject(self, &UIWindow.touchesShowingControllerKey, controller, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return controller!
        }
    }
    
    @objc(showTouches_sendEvent:) func showTouches_sendEvent(_ event: UIEvent) {
        self.showTouches_sendEvent(event)
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
    }
    
    static var didStart = false
    @objc public static func startShowingTouches() {
        guard !didStart else { return }
        didStart = true
        
        guard let originalMethod = class_getInstanceMethod(UIWindow.self, #selector(sendEvent(_:))),
            let newMethod = class_getInstanceMethod(UIWindow.self, #selector(showTouches_sendEvent(_:)))
        else {
            return
        }
        method_exchangeImplementations(originalMethod, newMethod)
    }
}

# GSTouchesShowingWindow-Swift

A simple tool that automatically **shows all touches** inside your app as they are happening, using a circular image indicator. It's useful for creating **App Previews** for the App Store or any kind of **app videos** where you need to demonstrate some rich user interaction that would be hard to showcase otherwise.

(Looking for Objective-C version? It's [here](https://github.com/LukasCZ/GSTouchesShowingWindow).)

## Example

<img src="ReadmeFiles/TouchesPreviewTimelines.gif" width="320px">

Short interaction in [Timelines](https://timelinesapp.io), my app for tracking time.

## Installation

GSTouchesShowingWindow is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'GSTouchesShowingWindow-Swift', :git => 'https://github.com/Cyberbeni/GSTouchesShowingWindow-Swift.git', :configurations => ['Debug']
```

Alternatively, you can just drag `GSTouchesShowingWindow-Swift/Classes` and `GSTouchesShowingWindow-Swift/Assets.xcassets` into your project.

## How to set it up

In your `AppDelegate.swift`, replace `var window: UIWindow?` with the following code:

```Swift
    #if DEBUG
    var customWindow: GSTouchesShowingWindow?
    var window: UIWindow? {
        get {
            customWindow = customWindow ?? GSTouchesShowingWindow(frame: UIScreen.main.bounds)
            return customWindow
        }
        set { }
    }
    #else
    var window: UIWindow?
    #endif
```

If you're using the CocoaPods integration, you also need to add the following import at the top of the file:
```Swift
import GSTouchesShowingWindow_Swift
```

And that's it!

### App Extensions
If you are using App Extensions (such as Today extension or Keyboard extension), you can also show touches in them.
First, you need to integrate GSTouchesShowingWindow-Swift in your App Extension target. If you're using CocoaPods, you need to add the pod like this:

```ruby
target 'Today Extension' do
    use_frameworks!	
    pod 'GSTouchesShowingWindow-Swift'
end
```

If you're not using CocoaPods, you need to either drag the `GSTouchesShowingWindow-Swift/Classes` into your extension's target, or you can set their **Target Membership** to include the extension as well:

![Setting the Target membership in Utilities / File inspector / Target membership](ReadmeFiles/Target-membership-instructions.png)


Then, in your `KeyboardViewController.m` or `TodayViewController.m`, add the following line near the end of `-viewDidLoad:` method:

```Swift
self.view.addGestureRecognizer(GSTouchesShowingGestureRecognizer())
```

Same as with main app target: if you're using the CocoaPods integration, you also need to import the module using:
```Swift
import GSTouchesShowingWindow_Swift
```

Note: In Today extensions (Widgets), the touch will disappear shortly after you start dragging (both horizontally and vertically). That's to be expected because system takes over control of the gesture.

## How it actually works

Inside the UIWindow subclass, I am overriding the `-sendEvent` method, processing all the events and directing them to a controller object that takes care of adding/moving/removing imageViews based on those events' touches. And then I call `[super sendEvent];` so that the touches are forwarded to the app itself. Refer to [Understanding Responders and the Responder Chain](https://developer.apple.com/library/content/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/HandlngEventsUsingtheResponderChain.html) to learn more. For extensions, a `UIGestureRecognizer` subclass is used because it's not possible to override window.

If you have any questions, you're welcome to get in touch with me on Twitter [@luksape](http://twitter.com/luksape). And if you use this when creating your app video, I'd love to hear from you!


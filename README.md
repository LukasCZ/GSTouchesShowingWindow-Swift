# TODO:
- restore example image
- recheck text.

# ShowTouches

A simple tool that automatically **shows all touches** inside your app as they are happening, using a circular image indicator. It's useful for creating **App Previews** for the App Store or any kind of **app videos** where you need to demonstrate some rich user interaction that would be hard to showcase otherwise.

## Example

<img src="ReadmeFiles/TouchesPreviewTimelines.gif" width="320px">

Short interaction in [Timelines](https://timelinesapp.io), the original creator's app for tracking time.

## Installation

GSTouchesShowingWindow is available through [Swift Package Manager](https://swift.org/package-manager/). To install it, simply add the url of this repository to your package dependencies.

## How to set it up

Just call `UIWindow.startShowingTouches()` (Also works with SwiftUI using [App](https://developer.apple.com/documentation/swiftui/app) and [WindowGroup](https://developer.apple.com/documentation/swiftui/windowgroup) added in Xcode 12.0)

And that's it!

### App Extensions
If you are using App Extensions (such as Today extension or Keyboard extension), you can also show touches in them. In your `KeyboardViewController.swift` or `TodayViewController.swift`, add the following line near the end of `viewDidLoad()` method:

```Swift
view.addGestureRecognizer(ShowTouchesGestureRecognizer())
```

Note: In Today extensions (Widgets), the touch will disappear shortly after you start dragging (both horizontally and vertically). That's to be expected because system takes over control of the gesture.

## How it actually works

Inside the UIWindow subclass, I am overriding the `sendEvent:` method, processing all the events and directing them to a controller object that takes care of adding/moving/removing colored views based on those events' touches. And then I call `[super sendEvent:];` so that the touches are forwarded to the app itself. Refer to [Understanding Responders and the Responder Chain](https://developer.apple.com/library/content/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/HandlngEventsUsingtheResponderChain.html) to learn more. For extensions, a `UIGestureRecognizer` subclass is used because it's not possible to override window.

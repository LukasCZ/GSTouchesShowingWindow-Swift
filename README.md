# ShowTouches

A simple tool that automatically **shows all touches** inside your app as they are happening, using a circular image indicator. It's useful for creating **App Previews** for the App Store or any kind of **app videos** where you need to demonstrate some rich user interaction that would be hard to showcase otherwise.

## Example

<img src="ReadmeFiles/TouchesPreviewTimelines.gif" width="320px">

Short interaction in [Timelines](https://timelinesapp.io), the original creator's app for tracking time.

## Installation

ShowTouches is available through [Swift Package Manager](https://swift.org/package-manager/). To install it, simply add the url of this repository through `Xcode -> File -> Swift Packages -> Add Package Dependency...`

## How to set it up

Just call `UIWindow.startShowingTouches()` anywhere in your app. (Also works with SwiftUI using [App](https://developer.apple.com/documentation/swiftui/app) and [WindowGroup](https://developer.apple.com/documentation/swiftui/windowgroup) added in Xcode 12.0)

And that's it!

### App Extensions

If you are using App Extensions (such as Action extension or Keyboard extension), you can also show touches in them. Calling `UIWindow.startShowingTouches()` should work for those too.

### Only showing for specific views

If you only want to display touches for specific views (or the other method doesn't work for you), a gesture recognizer is also available: `view.addGestureRecognizer(ShowTouchesGestureRecognizer())`

## How it actually works

I am overriding the `sendEvent(_:)` method, processing all the events and directing them to a controller object that takes care of adding/moving/removing colored views based on those events' touches. And then I call `super.sendEvent(_:)` so that the touches are forwarded to the app itself. Refer to [Understanding Responders and the Responder Chain](https://developer.apple.com/library/content/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/HandlngEventsUsingtheResponderChain.html) to learn more.

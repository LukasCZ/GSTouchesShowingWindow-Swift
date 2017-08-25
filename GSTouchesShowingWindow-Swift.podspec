Pod::Spec.new do |s|
  s.name             = 'GSTouchesShowingWindow-Swift'
  s.version          = '1.0.3'
  s.summary          = 'UIWindow subclass that makes all touches in your app visible.'

  s.description      = <<-DESC
GSTouchesShowingWindow is a drop-in component (UIWindow subclass) that will visualize all touches in your app as they are happening. It's great for creating App Previews or any kind of app videos. (Update: Now it works for Keyboard and Today extensions as well. Refer to Readme for instructions.)
                       DESC

  s.homepage         = 'https://github.com/LukasCZ/GSTouchesShowingWindow-Swift'
  s.screenshots      = 'https://raw.githubusercontent.com/LukasCZ/GSTouchesShowingWindow-Swift/master/ReadmeFiles/Sample-touches-screenshot.png', 'https://raw.githubusercontent.com/LukasCZ/GSTouchesShowingWindow-Swift/master/ReadmeFiles/TouchesPreviewTimelines.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'Lukas Petr' => 'lukas@glimsoft.com' }
  s.source           = { :git => 'https://github.com/LukasCZ/GSTouchesShowingWindow-Swift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/luksape'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GSTouchesShowingWindow-Swift/Classes/**/*'
  s.resources = "GSTouchesShowingWindow-Swift/Assets.xcassets"

end

Pod::Spec.new do |spec|
    spec.name = "ChatAssist"
    spec.version = "0.1.0"
    spec.summary = "Readyly Chat Assist"
    spec.description = spec.summary
    spec.license = "Readyly App License"
    spec.homepage = "https://chatsdk.readyly.app/"
    spec.author = "Readyly"
    spec.platform = :ios
    spec.ios.deployment_target = "17.0"
    spec.source = { :git => "https://github.com/Readyly/chatassist-sdk-ios.git" }
    spec.resources = ["Resources/*.xcassets", "Resources/*.lproj"]
    spec.source_files = 'ChatAssist/Sources/**/*'
    spec.module_name      = spec.name
    spec.vendored_frameworks = 'ChatAssist.xcframework'
  end
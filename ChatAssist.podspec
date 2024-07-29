Pod::Spec.new do |spec|
    spec.name = "ChatAssist"
    spec.version = "0.1.2"
    spec.summary = "Readyly Chat Assist"
    spec.description = "Readyly Chat Assist SDK"
    spec.license = "Readyly App License"
    spec.homepage = "https://chatsdk.readyly.app/"
    spec.author = "Readyly"
    spec.platform = :ios
    spec.ios.deployment_target = "15.0"
    spec.source = { :git => "https://github.com/Readyly/chatassist-sdk-ios.git", :tag => "#{spec.version}"  }
    spec.source_files  = "Sources/ChatAssist/**/*.{swift,h,m}"
    spec.exclude_files = "Sources/ChatAssist/Exclude"
    spec.module_name = spec.name
    spec.swift_version = "5.0"
    
  end
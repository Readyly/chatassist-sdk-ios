# Chat Assist SDK

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Integration](#integration)
     - [Swift Package Manager](#swift-package-manager)
     - [CocoaPods](#cocoapods)
- [Usage](#usage)

<a name="introduction" />

## Introduction

Chat Assist SDK helps you to seamlessly integrate a chat window into your application, providing real-time messaging capabilities and enhancing user interaction.

<a name="installation" />

## Installation

Instructions on how to install the project.

<a name="prerequisites" />

### Prerequisites

List any prerequisites that need to be installed first.
- Xcode 15 or later
- CocoaPods (If CocoaPods is the package manager)

<a name="integration" />

## Integration

<a name="swift-package-manager" />

### Swift Package Manager

- In Xcode, open `File > Add Packages`. 
- Search **https://github.com/Readyly/chatassist-sdk-ios.git**
- ChatAssist should be listed. Click `Add Package`

<a name="cocoapods" />

### CocoaPods

You can use CocoaPods to install **ChatAssist** 

- To install Cocoapods to Mac, on the Terminal, run  `sudo gem install cocoapods`
- Adding ChatAssist to your Podfile:

```Pod
use_frameworks!

target 'MyApp' do
    pod 'ChatAssist'
end
```

- Run `pod install` on the terminal where Podfile is located.

<a name="usage" />

### Usage

- Add ChatAssist to the file where you want to use by

```swift
import ChatAssist
```

- Initialize the ChatAssist by providing the context parameters.
`orgName` : Organisation name
`profile` : Chat Profile *optional

```swift
let context = Chat.Context(orgName: "help", profile: "christmas")
var chat = try Chat(context: context)
```

- Start chat session

```swift
    chat?.startSession()
```

- End chat session

```swift
    chat?.endSession()
```

- Observing States and Messages from the Chat Server, add `ChatAssistDelegate`

```swift
extension ChatViewModel: ChatAssistDelegate {
    public func chatDidReceiveErrorAction(message: String) {
        print("Error occured: \(message)")
    }

    public func chatDidReceiveReadyAction() {
    
    }
    
    public func chatDidReceiveCloseAction() {
    
    }
    
    public func chatDidReceiveExpandAction() {
        
    }
    
    public func chatDidReceiveMinimiseAction() {
        
    }
}
```

- Sending user details

The payload type is dictionary.
If user details are not sent, the widget will prompt the user when required.

```swift
chat?.postMessage(type: .userDetails, payload: ["firstName":"Mauro",
                                                "lastName":"Icardi",
                                                "email":"mauro.icardi@mooail.com"])
```

- Sending additional details

The payload type is dictionary.
`details` within the payload will be attached to the ticket created during the session.
If the `append` option is `false` any prior additional details will be overwritten.

```swift
chat?.postMessage(type: .additionalDetails, payload: ["details":"diagnostics or relevant details",
                                                        "options": ["append":false]])
```


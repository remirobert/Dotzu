<p align="center">
  <img src ="https://raw.githubusercontent.com/liman123/DebugMan/master/Sources/Resources/images/debugman_logo.png"/>
</p>

[![Platform](https://img.shields.io/cocoapods/p/DebugMan.svg?style=flat)](http://cocoadocs.org/docsets/DebugMan)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/DebugMan.svg)](https://img.shields.io/cocoapods/v/DebugMan.svg)
<img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License MIT"/>

# DebugMan

iOS debugger tool for Swift

## Introduction

`DebugMan` is inspired by [remirobert/Dotzu](https://github.com/remirobert/Dotzu) and [JxbSir/JxbDebugTool](https://github.com/JxbSir/JxbDebugTool), but more powerful:

- display all app logs in different colors as you like.
- display all app network http requests details, including third-party SDK in app.
- display app device informations and app identity informations.
- display app crash logs.
- filter keywords in app logs and app network http requests.
- app memory real-time monitoring.

## Requirements

- iOS 8.0+
- Xcode 9.0+
- Swift 3.0+

## Installation

You can use [CocoaPods](http://cocoapods.org/) to install `DebugMan` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'your_project' do
pod 'DebugMan', '~> 4.3.0' , :configurations => ['Debug']
end
```

- use `~> 4.3.0` if your project use Swift 4
- use `~> 3.3.0` if your project use Swift 3

## Usage

	import DebugMan
	
	@UIApplicationMain
	class AppDelegate: UIResponder, UIApplicationDelegate {
	
	    var window: UIWindow?
	
	    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
	        
	        #if DEBUG
	            //step 1: initialize DebugMan
	            DebugMan.shared.enable()
	        #endif
	        
	        return true
	    }
	}
	
	public func print<T>(file: String = #file,
	                     function: String = #function,
	                     line: Int = #line,
	                     _ message: T,
	                     _ color: UIColor? = nil)
	{
	    #if DEBUG
	        //step 2: override system print method
	        DebugManLog(file, function, line, message, color)
	    #endif
	}

## Screenshots

👉 Tips 👈

You can temporarily hide the black ball by shaking iPhone or Simulator. Then if you want to show the black ball, just shake again.😃APP memory real-time monitoring data displayed on the black ball.😃

<img src="https://raw.githubusercontent.com/liman123/DebugMan/master/Screenshots/1.png" width="200">
<img src="https://raw.githubusercontent.com/liman123/DebugMan/master/Screenshots/2.png" width="200">
<img src="https://raw.githubusercontent.com/liman123/DebugMan/master/Screenshots/3.png" width="200">
<img src="https://raw.githubusercontent.com/liman123/DebugMan/master/Screenshots/4.png" width="200">
<img src="https://raw.githubusercontent.com/liman123/DebugMan/master/Screenshots/5.png" width="200">
<img src="https://raw.githubusercontent.com/liman123/DebugMan/master/Screenshots/6.png" width="200">
<img src="https://raw.githubusercontent.com/liman123/DebugMan/master/Screenshots/7.png" width="200">

## Contact

* Author: liman
* WeChat: liman_888
* QQ: 723661989
* E-mail: gg723661989@gmail.com

Welcome to star `DebugMan`. 😃

If you have any questions, welcome to open issues. 😃

## License

`DebugMan` is released under the [MIT License](http://www.opensource.org/licenses/MIT).

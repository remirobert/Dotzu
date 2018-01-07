<p align="center">
  <img src ="https://raw.githubusercontent.com/liman123/DebugMan/master/Sources/Resources/images/debugman_logo.png"/>
</p>

[![Platform](https://img.shields.io/cocoapods/p/DebugMan.svg?style=flat)](http://cocoadocs.org/docsets/DebugMan)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/DebugMan.svg)](https://img.shields.io/cocoapods/v/DebugMan.svg)
<img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License MIT"/>

# DebugMan

iOS debugger tool for Swift

## Introduction

`DebugMan` is inspired by [remirobert/Dotzu](https://github.com/remirobert/Dotzu) and [JxbSir/JxbDebugTool](https://github.com/JxbSir/JxbDebugTool), but it is more powerful than them.

- display all APP logs in different colors as you like.
- show all APP network requests (include third-party SDK in APP).
- filter keywords in APP logs and APP network requests.
- APP device informations and APP identity informations.
- APP crash logs.
- APP memory real-time monitoring.

## Installation

You can use [CocoaPods](http://cocoapods.org/) to install `DebugMan` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'your_project' do
pod 'DebugMan', '~> 4.2.7' , :configurations => ['Debug']
end
```
The latest version is 4.2.7

- use `~> 4.2.7` if your project use Swift 4
- use `~> 3.2.7` if your project use Swift 3

## Usage

	//AppDelegate.swift

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //the simplest usage of DebugMan
        DebugMan.shared.enable()
        
        return true
    }
    
For advanced usage, you can check the parameters of function: `enable()` 

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
* E-mail: 723661989@163.com && gg723661989@gmail.com

If you like `DebugMan`, you can star this project. Thanks! 😃

## License

`DebugMan` is released under the [MIT License](http://www.opensource.org/licenses/MIT).

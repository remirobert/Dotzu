<p align="center">
  <img src ="https://cloud.githubusercontent.com/assets/3276768/22606144/035a4a28-ea53-11e6-8359-323c214c2439.png"/>
</p>

# Dotzu
<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<img src="https://img.shields.io/badge/swift3-compatible-green.svg?style=flat" alt="Swift 3 compatible" />
<img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat" alt="Carthage compatible" />
<img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License MIT" />

The debbuger tool for iOS developer. Display *logs*, *network request*, *device informations*, *crash logs* while using the app. Easy accessible with **its bubble head button** 🔘.

<p align="center">
  <img src ="https://cloud.githubusercontent.com/assets/3276768/22604003/dd161210-ea49-11e6-923d-b4b32acfd642.gif"/>
</p>

## Usage

In the `AppDelegate` instanciate `Dotzu manager`

```swift
   func application(_ application: UIApplication,
   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
   
        Dotzu.sharedManager.displayWindow()
        return true
   }
```

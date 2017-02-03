<p align="center">
  <img src ="https://cloud.githubusercontent.com/assets/3276768/22606144/035a4a28-ea53-11e6-8359-323c214c2439.png"/>
</p>

# Dotzu
<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<img src="https://img.shields.io/badge/swift3-compatible-green.svg?style=flat" alt="Swift 3 compatible" />
<img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat" alt="Carthage compatible" />
<img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License MIT" />

The debbuger tool for iOS developer. Display *logs*, *network request*, *device informations*, *crash logs* while using the app. Easy accessible with **its bubble head button** 🔘. Easy to integrate in any apps, to handle development or testing apps **easier**.

</br>
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

## Logs

Dotzu overide `print`, so you can use it and see your logs. otherwise, you can add level, and get more details (file, and line) about your logs. With the `Logger` class provided by the framework. Get new logs count on the badge, or *warning/error* notification on the bubble head.
<a href="http://promisesaplus.com/">
    <img src="https://cloud.githubusercontent.com/assets/3276768/22610650/ba71cf2a-ea66-11e6-8f94-6d3c9916740e.gif" align="right" />
</a>
```swift
print("logs")
Logger.verbose("some logs")
Logger.info("infos")
Logger.warning("warning ! ⚠️")
Logger.error("error ❌")
```

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

Add this to your Cartfile:

```ruby
github "remirobert/Dotzu"
```

### [CocoaPods](https://cocoapods.org)

Comming soon

### Manually

Drag the source files into your project.

## Contact

* Rémi ROBERT
* Twitter: [@remi936](https://twitter.com/remi936)

## License

Dotzu is released under the [MIT License](http://www.opensource.org/licenses/MIT).

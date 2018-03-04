<h3 align="center">
<img src="logo.png" width="200" />
</h3>
<h1 align="center">
Configuration
</h1>

[![Version](https://img.shields.io/cocoapods/v/Configuration.svg?style=flat)](http://cocoapods.org/pods/Configuration)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/Configuration.svg?style=flat)](http://cocoapods.org/pods/Configuration)
[![Build Status](https://travis-ci.org/vincentsaluzzo/Configuration.svg)](https://travis-ci.org/vincentsaluzzo/Configuration)
[![Swift 4](https://img.shields.io/badge/Language-Swift%204-orange.svg)](https://developer.apple.com/swift/)
[![codecov](https://codecov.io/gh/vincentsaluzzo/Configuration/branch/develop/graph/badge.svg)](https://codecov.io/gh/vincentsaluzzo/Configuration)
[![License](https://img.shields.io/cocoapods/l/Configuration.svg?style=flat)](http://cocoapods.org/pods/Configuration)


Configuration is a light framework which was designed to simplify the use of configuration in an application.

Because some people prefere to use `UserDefaults`, some other else prefere using a `JSON` file, and some data need to be extra secured by using Apple Keychain, you will probably find different way for defining configuration property in your iOS developer life.

Configuration will give you a abstraction layer from the configuration saving implementation by using `generics` and `protocol programming`.

## Instalation

Configuration is available through [CocoaPods](http://cocoapods.org), [Carthage](https://github.com/Carthage/Carthage) and [Swift Package Manager](https://swift.org/package-manager/). Follow the steps belows.

#### CocoaPods

To install it, simply add the following line to your Podfile:

```ruby
use_frameworks!
pod "Configuration"
```

#### Carthage

To install it, simply add the following line to your Cartfile:

```ruby
github 'vincentsaluzzo/Configuration'
```

#### Swift Package Manager

Add this package line dependcies inside your `Package.swift` file:

```swift
    .package(url: "https://github.com/vincentsaluzzo/Configuration", from: "1.0.0"),
```

## How to use

Configuration itself is very light: two protocols. One for defining configuration propery and an other for defining configuration saving implementation. By default, Configuration have a built-in `UserDefaults` implementation.

To create configuration property, just create an enumeration like : 

```swift
enum Configuration: String {
    case username
    case email
}
```

The configuration **must conform** to `RawRepresentable` protocol. In Swift, to do this on `enum`, you just have to type it, like with `String` in the above example.

Next, you need to add conformance for `ConfigurationKey` protocol on your `enum` : 

```swift
extension Configuration: ConfigurationKey {
    var `protocol`: ConfigurationProtocol { 
        return UserDefaultsConfigurationsProtocol() 
    }
}
```

Here we have used the `UserDefaults` built-in implementation.

And that's all, you havec `Configuration`-ready implementation.

### Getting property

To get property, you simply need to use `get()` method on your property. By using generics, the decoded value type depends on the receiver type.

```swift
do {
    let currentUsername: String? = try Configuration.username.get()
} catch {
    // ... "oups"
}    
```

A property couldn't exist in the application lifecycle, so be sure to add `Optional` type in receiver.

Because the property type aren't strongly defined, you need to encaspulate call in `do-catch` block.

### Setting property

To set property, just use `set(_:)` method on your property. By using generics, like for getting, the encoded value depends on the value type provided.

```swift
do {
    try Configuration.username.set("vincentsaluzzo")
} catch {
    // ... "oups"
}
```

### Remove property

To remove a property, you have to use `set(_:)` method on you property like for setting a new value to it but with a `nil` value.

```swift
do {
    try Configuration.username.set(nil as String?)
} catch {
    // ... "oups"
}
```

## Add a new implementation protocol

Configuration have `UserDefaults` built-in protocol but if you want to create an another implementatio, you just need to create `class` which should conform to `ConfigurationProtocol`.

This protocol define two methods for getting and setting a new value to a property. For an example, go on the `UserDefaultsConfigurationsProtocol`.

After that, just return your new implementation protocol in `protocol` property of your configuration `enum` and that's all!

## Author

* Vincent Saluzzo [@vincentsaluzzo](https://twitter.com/vincentsaluzzo)

## License

Configuration is available under the MIT license. See the LICENSE file for more info.
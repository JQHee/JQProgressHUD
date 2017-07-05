# JQProgressHUD
[![Version](https://img.shields.io/cocoapods/v/JQProgressHUD.svg?style=flat)](http://cocoapods.org/pods/JQProgressHUD)
[![License](https://img.shields.io/cocoapods/l/JQProgressHUD.svg?style=flat)](http://cocoapods.org/pods/JQProgressHUD)
[![Platform](https://img.shields.io/cocoapods/p/JQProgressHUD.svg?style=flat)](http://cocoapods.org/pods/JQProgressHUD)

#### [中文说明](readme.zh.md)

## Screenshots

![result.gif](http://upload-images.jianshu.io/upload_images/678898-64495045d8e44869.gif?imageMogr2/auto-orient/strip)

## Requirements

`JQProgressHUD ` works on ` "Xcode 8.2 , Swift 3 and ios 10+ to build. `
You will need the latest developer tools in order to build `JQProgressHUD `. Old Xcode versions might work, but compatibility will not be explicitly maintained.

## CocoaPods

CocoaPods is the recommended way to add JQProgressHUD to your project.

Add a pod entry for JQProgressHUD to your Podfile.
 
```
pod 'JQProgressHUD'
```
Second, install JQProgressHUD into your project:
 
```
pod install
```


## Manually

1. Download the latest code version .
2. Open your project in Xcode,drag the `JQProgressHUD ` folder into your project.  Make sure to select Copy items when asked if you extracted the code archive outside of your project.


## Usage

```
JQProgressHUDTool.jq_showToastHUD( msg: "this is toast")
```

or

```
JQProgressHUDTool.jq_showNormalHUD(msg: "loading...")

JQProgressHUDTool.jq_hideHUD()
```

For more examples, including how to use JQProgressHUD , take a look at the bundled demo project. API documentation is provided in the header file (JQProgressHUD.swift).

## License	

JQProgressHUD is released under the [Apache license 2.0](LICENSE). See LICENSE for details.

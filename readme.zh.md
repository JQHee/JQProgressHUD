
## 中文说明
####  `JQProgressHUD` 是一个 HUD 指示器。

#### 注意
`JQProgressHUD` 基于 `"Xcode 8.2 / Swift 3 / iOS 10` 而写 ，请在最新版 Xcode 来编译JQProgressHUD,旧版本的 Xcode 可能有效，但不保证会出现一些兼容性问题。

## CocoaPods

推荐使用 CocoaPods 安装。

1. 在 Podfile 中添加 `pod 'JQProgressHUD'`。
2. 执行 `pod install` 或 `pod update`。

## 手动安装
1. 通过 `Clone or download`下载 JQProgressHUD 文件夹内的所有内容。
2. 将 Source 内的源文件添加(拖放)到你的工程。
3. 导入 `JQProgressHUD` 。

## 使用

```
JQProgressHUDTool.jq_showToastHUD( msg: "this is toast")
```

or

```
JQProgressHUDTool.jq_showNormalHUD(msg: "loading...")

JQProgressHUDTool.jq_hideHUD() 
```

更多的使用用例可以看(ViewController.swift)以及头文件(JQProgressHUD.swift)。

## 许可

JQProgressHUD 使用 MIT 许可证，详情可见 [LICENSE](LICENSE) 文件。



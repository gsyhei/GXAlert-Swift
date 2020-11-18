# GXAlert-Swift
Swift版本基于UIView的菜单效果分类
有建议可以联系QQ交流群:1101980843，喜欢就给个star哦，谢谢关注！
<p align="center">
<img src="https://github.com/gsyhei/GXCardView-Swift/blob/master/QQ.jpeg">
</p>

先上Demo效果图
--
<p align="center">
<img src="https://github.com/gsyhei/GXAlert-Swift/blob/master/GXAlert.gif">
</p>

Requirements
--
<p align="left">
<a href="https://github.com/gsyhei/GXSegmentPageView"><img src="https://img.shields.io/badge/platform-ios%209.0-yellow.svg"></a>
<a href="https://github.com/gsyhei/GXSegmentPageView"><img src="https://img.shields.io/github/license/johnlui/Pitaya.svg?style=flat"></a>
<a href="https://github.com/gsyhei/GXSegmentPageView"><img src="https://img.shields.io/badge/language-Swift%205.0-orange.svg"></a>
</p>

Usage in you Podfile:
--

```
pod 'GXAlert-Swift'
```
* 其它版本 [OC版本](https://github.com/gsyhei/GXAlert)
```
pod 'GXAlert'
```
Extension
--

```swift

func show(to view: UIView? = nil,
          style: GXAlertManager.GXAlertStyle,
          backgoundTapDismissEnable: Bool = true,
          usingSpring: Bool = true,
          tapBlock: (() -> Void)? = nil,
          dismissBlock: (() -> Void)? = nil)

func hide(animated: Bool = true)

```

License
--
MIT

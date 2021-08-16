# ALPopup

### About

**ALPopup** - library for displaying pop-up windows with a native style (AirPods, Wi-Fi password sharing etc).

The library supports 2 types of popup windows:

- ALCardController - card window located at the bottom of the screen
- ALPopupController - regular popup window located in the center of the screen

All controllers have ready-made templates for fast information display, smooth animations, iPad and Mac support, gesture closing, and much more customization. Can also be used with UINavigationController.  You can play around with the example app.

<br/>

If you liked this library, please do not forget to put a `★ star`, it will help me in its development.

<br/>

<br/>

## Navigation

- [Requirements](#requirements)
- [Installation](#installation)
  - [Swift Package Manager](#Swift-Package-Manager)
  - [CocoaPods](#CocoaPods)
  - [Manually](#Manually)
- [Usage](#usage)
  - [Quick Start](#Quick-Start)
  - [Customization](#Customization)
    - [Base customization](#Base-customization)
    - [Template customization](#Template-customization)
- [License](#License)

## 

## Requirements

- iOS 11.0 + 
- Swift 5.3 +



## Installation

#### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate **ALPopup** click `File -> Swift Package -> Add Package Dependency` and insert:

```ogdl
https://github.com/alxrguz/ALPopup
```

#### CocoaPods

**ALPopup** is available through [CocoaPods](https://cocoapods.org/pods/ALProgressView). To install it, simply add the following line to your Podfile:

```ruby
pod 'ALPopup'
```

#### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate ALPopupController into your project manually. Put `Source/ALPopup` folder in your Xcode project. 



## Usage

#### Quick Start

First of all import library

```swift
import ALPopup
```

Use  `ALPopup.card` for create card (it is similar to the one shown when the airpods are connected to your device),  if you need a regular popup - use `ALPopup.popup` (it will be displayed in the middle of the screen).

For present controller use:

```swift
cardController.push(from: UIViewController, haptic: ALHaptic)
```

For dismiss controller use:

```swift
cardController.pop(completion: (() -> Void))
```



**There are 3 options for configure the controller:**

● As a template

Create controller with `.init(template: ALTemplateSettings)`

```swift
let popupVC = ALPopup.card(template: .init(
                                        title: "Hi",
                                        subtitle: "This is popup template controller",
                                        image: UIImage(systemName: "airpodspro"),
                                        privaryButtonTitle: "Connect",
                                        secondaryButtonTitle: "Not Now")
                )
popupVC.push(from: self)
```

All template fields are optional, if you do not specify some property, then it simply will not be shown.



● Using your controller

Create controller with `.init(controller: UIViewController)`

```swift
let baseViewController = BaseViewController()
let cardVC = ALPopup.card(controller: baseViewController)
cardVC.push(from: self)
```

In order for the size to be calculated correctly, you need your controller to be correctly laid out (If you have difficulty - see **Example App** `BaseViewController`). 



● Inherit from controller

```swift
class InheritedFromCardController: ALCardController { }

class InheritedFromPopupController: ALPopupControlle { }

let myCardVC = InheritedFromCardController()
myCardVC.push(from: self)

let myPopupVC = InheritedFromPopupController()
myPopupVC.push(from: self)
```

Be careful, if you inherit, then all your elements must be added to the contentView (see **Example App** `InheritedFromPopupController`)



#### Customization

##### **Base customization**

Is close Button show on controller

```swift
myPopupVC.isEnableCloseButton = true
```



Should the controller be closed by tap on the darkened area

```swift
myPopupVC.dismissByTapAround = true
```



Whether swipe to dismiss should be allowed. Defaults is true.

```swift
myPopupVC.allowsSwipeInteraction = true
```

If you set this to false, the pan gesture will continue to be recognized, but with noticeable resistance and the user won't be able to close the controller with a swipe.



The home indicator for iPhone X should be hidden or not. Defaults is `true`.

```swift
myPopupVC.isHomeIndicatorVisible = true
```



Rounding corners in superellipse for `contentView`.  Default is `true`

```swift
myPopupVC.superellipticRounding = true
```

Gives nicer and more correct rounding, but does not work well with frame animations.



##### Template customization

Suitable if the controller is created using: `.init(template: ALTemplateSettings)`

The template has 5 elements in total, all of them are open and can be changed at your discretion

```swift
// Create Controller
let popupVC = ALPopup.card(template: .init(
                                        title: "Hi",
                                        subtitle: "This is popup template controller",
                                        image: UIImage(systemName: "airpodspro"),
                                        privaryButtonTitle: "Connect",
                                        secondaryButtonTitle: "Not Now")
                )

// Setup templateView
popupVC.tempateView.titleLabel
popupVC.tempateView.subtitleLabel
popupVC.tempateView.imageView
popupVC.tempateView.primaryButton
popupVC.tempateView.secondaryButton

// Show 
vc.push(from: self)
```



Callbacks are prepared for handling button presses

```swift
popupVC.tempateView.primaryButtonAction = { [weak self] in }
popupVC.tempateView.secondaryButtonAction = { [weak self] in }
```



By the way, the template uses extended `ALActionButton` buttons, so it is more convenient to change their color using:

```swift
popupVC.tempateView.primaryButton.applyDefaultAppearance(with: .init(content: .systemBlue, background: .systemGroupedBackground))
```



## License

**ALPopup** is under MIT license. See the [LICENSE](https://github.com/alxrguz/ALPopup/blob/main/LICENSE) file for more info.


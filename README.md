![스크린샷 2022-02-05 오전 9 48 57](https://user-images.githubusercontent.com/72292617/152621594-94fbb5fa-4e28-46ca-a6dc-4530189d5256.png)
[![Version](https://img.shields.io/cocoapods/v/SuperStepper.svg?style=flat)](https://cocoapods.org/pods/SuperStepper)
[![License](https://img.shields.io/cocoapods/l/SuperStepper.svg?style=flat)](https://cocoapods.org/pods/SuperStepper)
[![Platform](https://img.shields.io/cocoapods/p/SuperStepper.svg?style=flat)](https://cocoapods.org/pods/SuperStepper)
[![CI Status](https://img.shields.io/travis/chanwoo/SuperStepper.svg?style=flat)](https://travis-ci.org/chanwoo/SuperStepper)

## What is SuperStepper?
**Everyone can be used and customized in various ways without errors in SwiftUI**   
Existing Stepper don't working properly in navigationLink    
But SuperStepper made up for them      
Actually, It's so convenient to use 🙌

## Various customized SuperStepper
![1](https://user-images.githubusercontent.com/72292617/152622772-7a844b41-d530-4a65-8eb6-22bfd356fd2c.gif) 
![2](https://user-images.githubusercontent.com/72292617/152622918-6efb4e25-3b83-474a-93b9-5df41f4b9231.gif)
![1](https://user-images.githubusercontent.com/72292617/152622999-0a5b2891-cf15-491f-a435-4d492d853618.gif)   
![123](https://user-images.githubusercontent.com/72292617/152623083-d7ee04cc-0b01-40d6-b04e-f87e410d751c.gif)
![2](https://user-images.githubusercontent.com/72292617/152623356-d96b5c4b-a844-4dbe-a39f-2516a89d4ff5.gif)
![23](https://user-images.githubusercontent.com/72292617/152623426-b603bf3c-7748-45f4-939a-59c23bcd3c43.gif)   

## How to use SuperStepper?
**Just crazy simple**   
import SuperStepper first 💪
- Basic
```swift
struct YourView: View {
  @State var count: Int = 1
  
  var body: some View {
    VStack {
      SuperStepperView(count: $count)
      Text("count number is \(count)")
    }
  }
}
```   
need to state property for binding with SuperStepper   
- Customize
```swift
struct YourView: View {
  @State var count: Int = 1
  
  var body: some View {
    VStack {
      SuperStepperView(
        count: $count,
        steppingCount: 2,
        minimumCount: 10,
        maximumCount: 30,
        decreaseTitleText: "DOWN",
        increaseTitleText: "UP",
        decreaseTitleColor: .red,
        minimumDecreaseTitleColor: .gray,
        increaseTitleColor: .blue,
        maximumIncreaseTitleColor: .gray,
        separatorColor: .black,
        seperatorWidth: 5,
        separatorHeight: 20,
        backgroundColor: .yellow,
        cornerRadius: 20,
        stepperSpacing: 5
      )
      Text("count number is \(count)")
    }
  }
}
```   
Everything we want 😀   
If your're curious, use the code in the example forlder   

## Requirements
**only can use in SwiftUI**   
- iOS >= 14.0   
- Xcode 11 / Swift 5   

## Cocoapods Install
Add ``pod 'SuperStepper'` to your Podfile.    
SuperStepper is available through [CocoaPods](https://cocoapods.org).    
To install it, simply add the following line to your Podfile:   
```ruby
pod 'SuperStepper'
```

## Swift Package Manager Install
See you soon 🙏🏻

## Carthage Install
See you soon 🙏

## How to contribute
**In the case below, please send us a PR 🙌
- Typo correction
- Add a better Feature
- Fix Error
- Better clean code
- And everything else that you think of

## Special Thanks
**Please contribute and take your place 🙇🏻**

## Author
[GREENOVER](https://github.com/GREENOVER), humains29@gmail.com

## License
SuperStepper is available under the MIT license. See the LICENSE file for more info.

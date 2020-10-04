---
title: "Storing Colors in Core Data—The Whole Story"
date: 2020-10-04T01:46:42+02:00
layout: post
draft: true
categories: Eventail
tags:
 - Core Data
 - Swift
---

The task: Store colors (`Color`, `UIColor` and `CGColor`) in Core Data, while remaining 100% compatible with the SwiftUI color picker.

# Setting Up the Core Data Model

In your model add an attribute to your entity and set its type to _Transformable_. Select it and in the Data Model Inspector (right pane in Xcode, last tab) set the _Transformer_ to "SerializableColorTransformer" and _Custom Class_ to "SerializableColor".

These two strings are magic values, and I'll explain their origin later.

The whole thing should look like this:

![ss-xcode-data-model]

[ss-xcode-data-model]: /images/core-data-colors-xcode.png

# Code Implementation

Core Data has several requirements on what _can_ be stored. It has to be `NSCoding` or `NSSecureCoding`. This in turn means that it has to be an Obj-C class. This rules out both `CGColor` (a non-Obj-c class) and `Color` (a struct).

In my case I don't care about color spaces other than P3 and sRGB. Let us create a class that stores red, green, blue and alpha components and a color space. The class will transform any color space other than P3 into sRGB. 

Here is the whole listing for the class, which I called `SerializableColor`. This is where the magic string for _Custom Class_ in the previous section comes from.

```swift
// SerializableColor.swift

import Foundation
import struct CoreGraphics.CGFloat
import class CoreGraphics.CGColor
import class CoreGraphics.CGColorSpace
import class UIKit.UIColor
import struct SwiftUI.Color

public class SerializableColor: NSObject, NSCoding, NSSecureCoding {
  public static var supportsSecureCoding: Bool = true
  
  public enum SerializableColorSpace: Int {
    case sRGB = 0
    case displayP3 = 1
  }
  
  let colorSpace: SerializableColorSpace
  let r: Float
  let g: Float
  let b: Float
  let a: Float
  
  public func encode(with coder: NSCoder) {
    coder.encode(colorSpace.rawValue, forKey: "colorSpace")
    coder.encode(r, forKey: "red")
    coder.encode(g, forKey: "green")
    coder.encode(b, forKey: "blue")
    coder.encode(a, forKey: "alpha")
  }
  
  required public init?(coder: NSCoder) {
    colorSpace = SerializableColorSpace(rawValue: coder.decodeInteger(forKey: "colorSpace")) ?? .sRGB
    r = coder.decodeFloat(forKey: "red")
    g = coder.decodeFloat(forKey: "green")
    b = coder.decodeFloat(forKey: "blue")
    a = coder.decodeFloat(forKey: "alpha")
  }
  
  init(colorSpace: SerializableColorSpace, red: Float, green: Float, blue: Float, alpha: Float) {
    self.colorSpace = colorSpace
    self.r = red
    self.g = green
    self.b = blue
    self.a = alpha
  }
  
  convenience init(from cgColor: CGColor) {
    var colorSpace: SerializableColorSpace = .sRGB
    var components: [Float] = [0, 0, 0, 0]
    
    // Transform the color into sRGB space
    if cgColor.colorSpace?.name == CGColorSpace.displayP3 {
      if let p3components = cgColor.components?.map({ Float($0) }),
         cgColor.numberOfComponents == 4 {
        colorSpace = .displayP3
        components = p3components
      }
    } else {
      if let sRGB = CGColorSpace(name: CGColorSpace.sRGB),
         let sRGBColor = cgColor.converted(to: sRGB, intent: .defaultIntent, options: nil),
         let sRGBcomponents = sRGBColor.components?.map({ Float($0) }),
         sRGBColor.numberOfComponents == 4 {
        components = sRGBcomponents
      }
    }
    self.init(colorSpace: colorSpace, red: components[0], green: components[1], blue: components[2], alpha: components[3])
  }
  
  convenience init(from color: Color) {
    self.init(from: UIColor(color))
  }
  
  convenience init(from uiColor: UIColor) {
    self.init(from: uiColor.cgColor)
  }  
  
  var cgColor: CGColor {
    return uiColor.cgColor
  }
  
  var color: Color {
    return Color(self.uiColor)
  }
  
  var uiColor: UIColor {
    if colorSpace == .displayP3 {
      return UIColor(displayP3Red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
    } else {
      return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
    }
  }
}

// MARK: Transformer Class
// For CoreData compatibility.

@objc(SerializableColorTransformer)
class SerializableColorTransformer: NSSecureUnarchiveFromDataTransformer {
  override class var allowedTopLevelClasses: [AnyClass] {
    return super.allowedTopLevelClasses + [SerializableColor.self]
  }
  
  public override class func allowsReverseTransformation() -> Bool {
    return true
  }
  
  public override func transformedValue(_ value: Any?) -> Any? {
    guard let data = value as? Data else {return nil}
    return try! NSKeyedUnarchiver.unarchivedObject(ofClass: SerializableColor.self, from: data)
  }
  
  public override func reverseTransformedValue(_ value: Any?) -> Any? {
    guard let color = value as? SerializableColor else {return nil}
    return try! NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
  }
}

```

The important parts are described as follows.

To register the transformer (explained below), add this line to the `init()` method of your `@main`. For example

```swift
@main
struct Eventail_v4App: App {
  init() {
    // ...
    ValueTransformer.setValueTransformer(
      SerializableColorTransformer(),
      forName: NSValueTransformerName(
        rawValue: "SerializableColorTransformer"))
  }
  // ...
}
```

The `rawValue` is where the _Transformer_ magic string in the model come from.

## Deeper dive

Instead of commenting the file excessively, here are explanations of details.

### NSCoding inheritance

For this we implement `encode(with coder: NSCoder)` and `init?(coder: NSCoder)`. These methods will enable the class to be serialized and deserialized using any standard decoder/encoder.

Note: As you can see this class will interpret any unknown color space as sRGB, this means that this is not backwards compatible.

### Color space transformations

These happen in two places. When encoding the value, the class always passes through CGColor as this is the only color type that can be split into components.

> Note: In init from `Color` I bounce through init from `UIColor`, this is because weirdly `Color.blue.cgColor == nil` but `UIColor(Color.blue).cgColor` has a value.

For deserialization I always pass through `UIColor` as this type has convenience initializers for both sRGB and P3 colorspaces.

### Transformer

Core Data can write only a few basic types, including `NSData`. Transformers are classes that can be registered for specific types and transform them into, and from `NSData`.

In order to implement a transformer you need to do three things:

- Write a class which inherits from `NSSecureUnarchiveFromDataTransformer` and overrides the `allowedTopLevelClasses` class variable adding your *class type* to the list
- Override the `transformedValue` and `reverseTransformedValue` methods. These are named as seen from CoreData perspective.
    - `transformedValue` transforms `NSData` into your class, in this case `SerializableColor`.
    - `reverseTransformedValue` transforms the class into `NSData`. You do not need to implement this method if you are never writing to CoreData yourself. In this case change the return value of `allowsReverseTransformation` to `false`.
- Register the transformer in your `@main` somewhere.

<aside class="warning">
Important: Do not forget to register the class!
</aside>
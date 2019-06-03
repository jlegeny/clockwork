---
title: "Segmented Control With Color Images"
date: 2019-05-09T22:57:41+02:00
layout: post
categories: Eventail
tags:
  - Swift
  - UIKit
---

The default `UISegmentedControl` does not support color images. As I wanted to have some in Eventail, I have developed a quick replacement for the default view. It tries to copy the API as closely as possible.

I use some helper function from my "utility" library:

```swift
extension Collection {
  
  /// Return an element of a collection or nil
  subscript(optional i: Index) -> Iterator.Element? {
    return self.indices.contains(i) ? self[i] : nil
  }
  
  /// Iterate over collection elements, progressively yielding the previous, current and next element
  func rollOver(closure: (Self.Element?, Self.Element, Self.Element?) -> Void) {
    var prev: Self.Element? = nil
    for i in self.indices {
      let next = self[optional: self.index(after: i)]
      closure(prev, self[i], next)
      prev = self[i]
    }
  }

}
```

The class itself is simple and is `@IBDesignable`. Unfortunately, Xcode does not (yet) support `@IBInspectable` arrays so I expose three UIImage variables. If you need to add segments, copy and paste a few of those.


```swift
//  ImageSegmentedControl.swift

import Foundation
import UIKit

@IBDesignable
class ImageSegmentedControl: UIControl {
  // @IBInspectable does not support arrays yet, but a segmented control does
  // not really need to have too many elements
  @IBInspectable var image1: UIImage? = nil {
    didSet {
      images[0] = image1
    }
  }
  
  @IBInspectable var image2: UIImage? = nil {
    didSet {
      images[1] = image2
    }
  }
  
  @IBInspectable var image3: UIImage? = nil {
    didSet {
      images[2] = image3
    }
  }

  /// Currently selegted segment
  public var selectedSegmentIndex: Int = 0

  // A nil image will represent a non-existing segment
  private var images = [UIImage?](repeating: nil, count: 3)
  
  private var segments = [UIView]()
  private var isSegmentEnabled = [Bool](repeating: true, count: 3)
  private var borders = [CALayer]()
  private var initialized: Bool = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func layoutSubviews() {
    if !initialized {
      layer.cornerRadius = 5
      layer.borderWidth = 1
      layer.borderColor = tintColor.cgColor
      
      clipsToBounds = true
      
      images.forEach {
        guard let image = $0 else {
          return
        }
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        segments.append(imageView)
      }
      
      segments.rollOver {
        prev, segment, _ in
        addSubview(segment)
        let previousAnchor = prev?.trailingAnchor ?? leadingAnchor
        NSLayoutConstraint.activate([
          segment.leadingAnchor.constraint(equalTo: previousAnchor),
          segment.centerYAnchor.constraint(equalTo: centerYAnchor),
          segment.heightAnchor.constraint(equalTo: heightAnchor),
          segment.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/CGFloat(segments.count)),
          ])
        if prev != nil {
          borders.append(segment.addLeftBorderWithColor(color: tintColor, width: 1))
        }
        segment.isUserInteractionEnabled = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImageSegmentedControl.handleTap(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.isEnabled = true
        segment.addGestureRecognizer(tapRecognizer)
      }
      
      initialized = true
    }
    
    borders.forEach { $0.frame = CGRect(origin: $0.frame.origin, size: CGSize(width: $0.frame.width, height: frame.height)) }
    
    for i in 0..<segments.count {
      segments[i].backgroundColor = i == selectedSegmentIndex ? tintColor : nil
      segments[i].isUserInteractionEnabled = isSegmentEnabled[i]
      segments[i].alpha = isSegmentEnabled[i] ? 1 : 0.25
    }
    
    super.layoutSubviews()
  }
  
  @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
    if let i = segments.firstIndex(where: { $0 == recognizer.view }) {
      selectedSegmentIndex = i
      setNeedsLayout()
      UIView.animate(withDuration: 0.3) {
        self.layoutIfNeeded()
      }
      sendActions(for: .valueChanged)
    }
  }
  
  func setEnabled(_ enabled: Bool, forSegmentAt segmentIndex: Int) {
    // We need to store the enabled/disabled state because the segments
    // can be actually initialized after this method is called
    isSegmentEnabled[segmentIndex] = enabled
    if let segment = segments[optional: segmentIndex] {
      segment.isUserInteractionEnabled = enabled
      segment.alpha = enabled ? 1 : 0.25
    }
  }
  
}
```

Some features of this view:

- Exposes the currently selected segment via `selectedSegmentIndex` akin to `UISegmentedControl`
- Inherits from UIControl so it has all of the outlets for common events. Only the `valueChanged` event fires though.
- Is `@IBDesignable` so you can see how will it look

And this is how it looks in Xcode

![screenshot]

[screenshot]: /images/swift/image-segmented-control.png
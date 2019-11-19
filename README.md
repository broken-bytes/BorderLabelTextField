# BorderLabelTextField

[![Version](https://img.shields.io/cocoapods/v/BorderLabelTextField.svg?style=flat)](https://cocoapods.org/pods/BorderLabelTextField)
[![License](https://img.shields.io/cocoapods/l/BorderLabelTextField.svg?style=flat)](https://cocoapods.org/pods/BorderLabelTextField)
[![Platform](https://img.shields.io/cocoapods/p/BorderLabelTextField.svg?style=flat)](https://cocoapods.org/pods/BorderLabelTextField)

BorderLabelTextField is a subclass of UITextField that adds a label above the input that breaks the border of the UITextField.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![Screenshot](/Example/Sreenshot1.jpg?raw=true "Screenshot")

## Installation

BorderLabelTextField is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BorderLabelTextField'
```

## Usage

Using this UITextField subclass is straighforward.

1. Drag an UITextField into your Storyboard
2. Set 'Custom Class' property field to this class called 'BorderLabelTextField'
3. In the TextField properties, set the Border style to any other than the preselected one as it displays an unwanted border around the TextField
4. Assign Inspectable properties to your desire.

Alternatively, instantiate via code and set the desired properties.


## Limitations

Due to the nature of IBInspectable properties, it is possible to set values that break the design of the TextField. This contains things like a label that takes all the space of the TextField, Borders that take up all space etc.
While these problems will persists for some time until a reasonable fix is found, it is easy to work around them by testing what your TextField looks like.
These Properties are all user defined so a runtime issue with these limitations is very unlikely to occur.


## Author

broken-bytes, dev@broken-bytes.io


## License

BorderLabelTextField is available under the MIT license. See the LICENSE file for more info.

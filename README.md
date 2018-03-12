# RXProgressBar

[![CI Status](http://img.shields.io/travis/m1a7/RXProgressBar.svg?style=flat)](https://travis-ci.org/m1a7/RXProgressBar)
[![Version](https://img.shields.io/cocoapods/v/RXProgressBar.svg?style=flat)](http://cocoapods.org/pods/RXProgressBar)
[![License](https://img.shields.io/cocoapods/l/RXProgressBar.svg?style=flat)](http://cocoapods.org/pods/RXProgressBar)
[![Platform](https://img.shields.io/cocoapods/p/RXProgressBar.svg?style=flat)](http://cocoapods.org/pods/RXProgressBar)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RXProgressBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RXProgressBar'
```
## RXProgressBar
The library is an account Manager with cells. You can transfer the data models which confrom  "RXInstructionModelProtocol" protocol to the RXProgressBar after that, it will do all the work for you.
Object which conform this protocol, must have next properties:

```json
    {
        instruction : "Wash the pumpkin",
            images : [
                        {
                        "url"     : "https:///site.com/1.jpg",
                        "title"   : "Pumplin ",
                        "summary" : "it should be bright",
                        "credit"  : "Wash and wipe the pumpkin dry"
                        },

                        {
                        "url"     : "https:///site.com/2.jpg",
                        "title"   : "Pumplin ",
                        "summary" : "it should be bright",
                        "credit"  : "Wash and wipe the pumpkin dry"
                        }
                     ]
        }
```


## Author

m1a7, thisismymail03@gmail.com

## License

RXProgressBar is available under the MIT license. See the LICENSE file for more info.

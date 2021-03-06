# Jarvis

[![Platform](https://img.shields.io/badge/platform-ios%20|%20osx%20|%20tvos%20|%20watchos-blue.svg)](https://developer.apple.com)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)
[![pod 1.3.1](https://img.shields.io/badge/pod-1.3.1-blue.svg)]()
[![Swift 4](https://img.shields.io/badge/Swift-4.0.x-orange.svg)]()

[![TheMindStudios](https://github.com/TheMindStudios/WheelPicker/blob/master/logo.png?raw=true)](https://themindstudios.com/)

Jarvis is a lightweight network abstraction layer, built on top of Alamofire. It can be used to dramatically simplify client-to-server communication.

## Features

- [x] Generic, protocol-based implementation
- [x] Support for iOS/macOS/tvOS/watchOS/
- [x] Easy to work with MultipartFormData
- [x] Support Codable protocol in Swift 4
- [x] Ability to log Response

## Overview

We designed Jarvis to be simple to use and also very easy to customize. After initial setup, using Jarvis is very straightforward:

```swift
api.getPosts(for: page) { response in
    switch response.result {
    case .success(let posts):
        print("Received Posts: \(posts)")
    case .failure(let error):
        print("Posts request failed, parsed error: \(error)")
    }
}
```

## Usage

1. Import `Jarvis` module to your `APIClient` class

```swift
import Jarvis
```

2. Add implementation for `RequestDataProvider` protocol. `RequestDataProvider` has default implementation, so you can set just properties you need:     

```swift
struct PostsListAPIClient {
    
    enum Route: RequestDataProvider {
        
        case get(page: Int)
        
        var method: HTTP.Method {
            return .get
        }
        
        var baseUrl: URLConvertible {
            
            return URL(string: "http://jsonplaceholder.typicode.com")!
        }
        
        var path: String {
            
            switch self {
            case .get:
                return "posts"
            }
        }
        
        var parameters: Parameters? {
            
            switch self {
            case .get(let page):
                return ["page": page]
            }
        }
    }
}
```

3. Make you sure that you model support protocol `Decodable`

```swift
struct Post: Decodable {
    
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
```


3. Sending requests

```swift
func getPosts(for page: Int, completion: @escaping (_ response: Response<[Post], APIError>) -> Void) {
        
    let request = Route.get(page: page)
    Jarvis.request(request).responseDecodable(completion: completion)
}
```

3. Handling response

```swift
api.getPosts(for: page) { response in
    switch response.result {
    case .success(let posts):
        print("Received Posts: \(posts)")
    case .failure(let error):
        print("Posts request failed, parsed error: \(error)")
    }
}
```

#### Podfile

To integrate `Jarvis` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target 'TargetName' do
  pod 'Jarvis'
end
```

Then, run the following command:

```bash
$ pod install
```

## License

Jarvis is available under the MIT license. See the LICENSE file for more info.

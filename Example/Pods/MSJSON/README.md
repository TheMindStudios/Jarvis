# MSJSON

MindStudios library for JSON parsing

## Requirements

iOS 9.0+

## Installation

MSJSON is available through [MindStudios Podspecs repo](https://git.themindstudios.com/ios-frameworks/podspecs) only. To install
it, simply add the following lines to your Podfile:

```ruby
platform :ios, '9.0'

source 'git@git.themindstudios.com:ios-frameworks/podspecs.git'

target 'Target' do
    pod "MSJSON"
end
```

## Example Usage

### Getting JSON

```swift
let jsonData: Data = ...

let json: JSON = try jsonData.parse()
```

or just

```swift
let json: JSON = ["id" : 15, "title": "Awesome post"]
```

### Getting values from JSON

```swift
let string: String? = json["string_key"]?.string
let bool: Bool? = json["bool_key"]?.bool
let int: Int? = json["int_key"]?.int
let float: Float? = json["float_key"]?.float
let double: Double? = json["double_key"]?.double
let null: NSNull? = json["null_key"]?.null
let number: NSNumber? = json["number_key"]?.number
let array: [JSON]? = json["array_key"]?.array
```

## JSONParsable protocol

### Adding JSONParsable protocol support

```swift
struct User: JSONParsable {
    
    let id: Int
    let name: String?
    
    init?(json: JSON) {

        guard let id: Int = json["id"]?.int else {
            return nil
        }

        self.id = id
        self.name = json["name"]?.string
    }
}
```

### Creating model from json

```swift
let user: User? = User(json: json)
```

That's it

### Parsing complex models

```swift
struct Post: JSONParsable {
    
    let id: Int
    let title: String?
    let user: User?
    
    init?(json: JSON) {
        
        guard let id: Int = json["id"]?.int else {
            return nil
        }
        
        self.id = id
        self.title = json["title"]?.string
        self.user = json["user"]?.parse() // user should support JSONParsable protocol
    }
}
```

## Defining typed JSON keys

Step 1: Define your JSON keys in model class file by extending *JSONKeys*

```swift
fileprivate extension JSONKeys {
    static let id = JSONKey<Int>("id")
    static let name = JSONKey<String>("name")
}
```

Step 2: Use it in your JSONParsable model ```swift init?(json: JSON)``` method

```swift
struct User: JSONParsable {
    
    let id: Int
    let name: String?
    
    init?(json: JSON) {

        self.id = id
        self.name = json[.name]
    }
}
```

or fallback if json doesn't have required fields (pay attention that id key is *Int?* now):

```swift
fileprivate extension JSONKeys {
    static let id = JSONKey<Int?>("id")
    static let name = JSONKey<String>("name")
}

struct User: JSONParsable {
    
    let id: Int
    let name: String?
    
    init?(json: JSON) {

        guard let id: Int = json[.id] else {
            return nil
        }

        self.id = id
        self.name = json[.name]
    }
}
```

### Defining JSONKey for JSONParsable Type (nested models)

```swift
fileprivate extension JSONKeys {
    static let id = JSONKey<Int>("id")
    static let title = JSONKey<String?>("title")
    static let user = JSONKey<User?>("user")
    static let comments = JSONKey<[Comment]?>("comments")
}

struct Post: JSONParsable {
    
    let id: Int
    let title: String?
    let user: User?
    let user: Comment?
    
    init?(json: JSON) {
        
        id = json[.id]
        title = json[.title]
        user = json.parse(.user)
        comments = json.parse(.comments)
    }
}
```

The convenient dot syntax is only available if you define your keys by extending magic `JSONKeys` class. You can also just pass the `JSONKey` value in square brackets, or use a more traditional string-based API.

### Supported default types for dot syntax (JSONKey)

| Optional variant       | Non-optional variant  | Default value |
|------------------------|-----------------------|---------------|
| `String?`              | `String`              | `""`          |
| `Int?`                 | `Int`                 | `0`           |
| `Double?`              | `Double`              | `0.0`         |
| `Float?`               | `Float`               | `0.0`         |
| `Bool?`                | `Bool`                | `false`       |
| `JSON?`                | `n/a`                 | `n/a`         |

## Author

Max Mashkov, max@themindstudios.com

## License

MSJSON is available under the MIT license. See the LICENSE file for more info.

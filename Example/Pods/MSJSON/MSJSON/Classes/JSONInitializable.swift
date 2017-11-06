//
//  JSONInitializable.swift
//  Pods
//
//  Created by Max Mashkov on 9/14/16.
//
//

import Foundation

public protocol JSONInitializable {
    init?(json: JSON)
}

public protocol KeyedContainerDecodable {
    
    associatedtype KeysType: CodingKey
    
    init(container: KeyedDecodingContainer<KeysType>) throws
}

extension String: JSONInitializable  {

    public init?(json: JSON) {

        guard let string = json.string else {
            return nil
        }

        self.init(describing: string)
    }
}

extension Int: JSONInitializable  {
    
    public init?(json: JSON) {

        guard let int = json.int else {
            return nil
        }

        self.init(int)
    }
}

extension Float: JSONInitializable {
    
    public init?(json: JSON) {

        guard let float = json.float else {
            return nil
        }

        self.init(float)
    }
}

extension Double: JSONInitializable {
    
    public init?(json: JSON) {

        guard let double = json.double else {
            return nil
        }

        self.init(double)
    }
}

extension Bool: JSONInitializable {
    
    public init?(json: JSON) {

        guard let bool = json.bool else {
            return nil
        }

        self.init(bool)
    }
}

extension Optional: JSONInitializable {
    
    public init?(json: JSON) {
        
        if let wrappedType = Wrapped.self as? JSONInitializable.Type, let some = wrappedType.init(json: json) as? Wrapped {
            self = .some(some)
        } else {
            self = .none
        }
    }
}

extension Array: JSONInitializable {

    public init?(json: JSON) {

        guard let type = Element.self as? JSONInitializable.Type, let array = json.array else {
            return nil
        }

        let items = array.flatMap { item in
            return type.init(json: item) as? Element
        }

        self.init(items)
    }
}

extension Dictionary: JSONInitializable {

    public init?(json: JSON) {

        guard let dictionary = json as? [Key: Value] else {
            return nil
        }

        self.init()

        for (key, value) in dictionary {
            self[key] = value
        }
    }
}

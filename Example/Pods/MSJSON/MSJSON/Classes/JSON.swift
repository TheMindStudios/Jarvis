//
//  JSON.swift
//  Pods
//
//  Created by Max Mashkov on 9/14/16.
//
//

import Foundation

//NSNull, NSNumber, NSString, NSArray, NSDictionary

public protocol JSON {
    subscript(key: String) -> JSON? { get }
    subscript(index: Int) -> JSON? { get }
    subscript<J: JSONInitializable>(key: String) -> J? { get }
    subscript<J: JSONInitializable>(index: Int) -> J? { get }

    var number: NSNumber? { get }
    var array: [JSON]? { get }
    var null: NSNull? { get }

    var string: String? { get }
    var bool: Bool? { get }
    var int: Int? { get }
    var float: Float? { get }
    var double: Double? { get }

    var stringValue: String { get }
    var boolValue: Bool { get }
    var intValue: Int { get }
    var floatValue: Float { get }
    var doubleValue: Double { get }
}

public extension JSON {

    public subscript(key: String) -> JSON? {
        return nil
    }

    public subscript(index: Int) -> JSON? {
        return nil
    }
    
    public subscript<J: JSONInitializable>(key: String) -> J? {
        return nil
    }
    
    public subscript<J: JSONInitializable>(index: Int) -> J? {
        return nil
    }

    var number: NSNumber? {
        return self as? NSNumber
    }

    var array: [JSON]? {
        return self as? [JSON]
    }

    var null: NSNull? {
        return self as? NSNull
    }

    var string: String? {
        return self as? String
    }

    var bool: Bool? {
        return number?.boolValue
    }

    var int: Int? {
        return number?.intValue
    }

    var float: Float? {
        return number?.floatValue
    }

    var double: Double? {
        return number?.doubleValue
    }

    var stringValue: String {
        return string ?? ""
    }

    var boolValue: Bool {
        return bool ?? false
    }

    var intValue: Int {
        return int ?? 0
    }

    var floatValue: Float {
        return float ?? 0
    }

    var doubleValue: Double {
        return double ?? 0
    }
}

extension NSNull: JSON {}
extension NSNumber: JSON {}
extension NSString: JSON {}

extension NSArray: JSON {

    public subscript(index: Int) -> JSON? {
        return index < count && index >= 0 ? self.object(at: index) as? JSON : nil
    }
    
    public subscript<J: JSONInitializable>(index: Int) -> J? {
        
        guard let json: JSON = self[index] else {
            return nil
        }
        
        return J(json: json)
    }
}

extension NSDictionary: JSON {

    public subscript(key: String) -> JSON? {
        return self.object(forKey: key) as? JSON
    }
    
    public subscript<J: JSONInitializable>(key: String) -> J? {
        
        guard let json: JSON = self[key] else {
            return nil
        }
        
        return J(json: json)
    }
}

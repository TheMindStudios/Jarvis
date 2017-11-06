//
//  JSONKey.swift
//  Pods
//
//  Created by Max Mashkov on 3/26/17.
//
//

import Foundation

open class JSONKeys {
    fileprivate init() {}
}

open class JSONKey<T>: JSONKeys {

    public let value: String
    
    public init(_ key: String) {
        self.value = key
        super.init()
    }
}

extension JSON {
    
    public subscript<J: JSONInitializable>(key: JSONKey<J?>) -> J? {
        
        guard let json = self[key.value] else {
            return nil
        }
        
        return J(json: json)
    }
    
    public subscript(key: JSONKey<String>) -> String {
        return self[key.value]?.string ?? ""
    }
    
    public subscript(key: JSONKey<Bool>) -> Bool {
        return self[key.value]?.bool ?? false
    }
    
    public subscript(key: JSONKey<Int>) -> Int {
        return self[key.value]?.int ?? 0
    }
    
    public subscript(key: JSONKey<Float>) -> Float {
        return self[key.value]?.float ?? 0.0
    }
    
    public subscript(key: JSONKey<Double>) -> Double {
        return self[key.value]?.double ?? 0.0
    }
    
    public subscript(key: JSONKey<JSON?>) -> JSON? {
        return self[key.value]
    }
}

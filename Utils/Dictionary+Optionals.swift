//
//  Dictionary+Optionals.swift
//  Utils
//
//  Created by Ernest Babayan on 09.10.2021.
//

public extension Dictionary {
    func removingOptionalValues<WrappedValue>() -> Dictionary<Key, WrappedValue> where Value == WrappedValue? {
        compactMapValues({ $0 })
    }
}

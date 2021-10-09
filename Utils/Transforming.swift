//
//  Transforming.swift
//  Utils
//
//  Created by Ernest Babayan on 09.10.2021.
//

public func transforming<T>(_ object: T, _ transform: (inout T) -> Void) -> T {
    var copy = object
    transform(&copy)
    return copy
}

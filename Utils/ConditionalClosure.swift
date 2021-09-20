//
//  ConditionalClosure.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 20.09.2021.
//

public func conditional<Result>(_ builder: () throws -> Result) rethrows -> Result {
    try builder()
}

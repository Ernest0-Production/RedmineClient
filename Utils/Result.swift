//
//  Result.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 20.09.2021.
//

public extension Result {
    static func create(_ builder: () -> Self) -> Self { builder() }
}

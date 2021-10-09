//
//  HTTPStatusCode.swift
//  HTTPClient
//
//  Created by Ernest Babayan on 09.10.2021.
//

public struct HTTPStatusCode {
    public init(_ raw: Int) { self.raw = raw }

    public let raw: Int
}

public extension HTTPStatusCode {
    static let OK = Self(200)

    static let movedPermanently = Self(301)

    static let notModified = Self(304)

    static let badRequest = Self(400)

    static let forbidden = Self(403)

    static let notFound = Self(404)

    static let methodNotAllowed = Self(405)
}

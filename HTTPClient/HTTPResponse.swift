//
//  HTTPResponse.swift
//  HTTPClient
//
//  Created by Ernest Babayan on 23.09.2021.
//

public struct HTTPResponse<Body> {
    public init(statusCode: HTTPStatusCode, headers: [String : String], body: Body) {
        self.statusCode = statusCode
        self.headers = headers
        self.body = body
    }

    public let statusCode: HTTPStatusCode

    public let headers: [String: String]

    public let body: Body
}

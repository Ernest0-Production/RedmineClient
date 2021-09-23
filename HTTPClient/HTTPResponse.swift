//
//  HTTPResponse.swift
//  HTTPClient
//
//  Created by Ernest Babayan on 23.09.2021.
//

public struct HTTPResponse {
    public init(statusCode: Int, headers: [String : String], body: Data?) {
        self.statusCode = statusCode
        self.headers = headers
        self.body = body
    }

    public let statusCode: Int

    public let headers: [String: String]

    public let body: Data?
}

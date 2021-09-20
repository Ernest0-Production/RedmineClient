//
//  HTTPRequest.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 20.09.2021.
//

import Foundation


public struct HTTPRequest {
    public init(host: String, path: String, method: HTTPRequest.Method, query: [HTTPRequest.Query], headers: [String : String], body: Data?) {
        self.host = host
        self.path = path
        self.method = method
        self.query = query
        self.headers = headers
        self.body = body
    }

    public let host: String

    public let path: String

    public enum Method {
        case get, post, delete, put
    }

    public let method: Method

    public struct Query {
        public init(key: String, value: String) {
            self.key = key
            self.value = value
        }

        public let key, value: String
    }

    public let query: [Query]

    public let headers: [String: String]

    public let body: Data?
}

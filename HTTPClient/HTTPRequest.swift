//
//  HTTPRequest.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 20.09.2021.
//

import Utils


public struct HTTPRequest {
    public init(host: String, path: String, method: HTTPRequest.Method, query: [HTTPRequest.Query], headers: [String : String], body: HTTPRequest.Body?) {
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

    public private(set) var headers: [String: String]

    public struct Body {
        public init(data: Data) {
            self.data = data
        }

        public let data: Data
    }

    public let body: Body?
}

public extension HTTPRequest {
    func settingHeader(name: String, value: String) -> Self {
        transforming(self) { copy in
            copy.headers[name] = value
        }
    }
}

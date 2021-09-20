//
//  Endpoint.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 19.09.2021.
//


public struct Endpoint {
    public init(path: String, method: Endpoint.Method, task: Endpoint.Task) {
        self.path = path
        self.method = method
        self.task = task
    }

    public let path: String

    public enum Method {
        case get, post, delete, put
    }

    public let method: Method

    public enum Task {
        case none

        case query(_ parameters: [String:Any?])

        case json([String:Any?])
        
        case formData(_ fields: [String:Any?])
    }

    public let task: Task
}

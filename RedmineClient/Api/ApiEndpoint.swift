//
//  ApiEndpoint.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 19.09.2021.
//

struct ApiEndpoint {
    let path: String

    enum Method {
        case get, post, delete, put
    }

    let method: Method

    enum Task {
        case none

        case query(_ parameters: [String:Any?])

        case json([String:Any?])
        
        case formData(_ fields: [String:Any?])
    }

    let task: Task
}

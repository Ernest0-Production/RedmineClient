//
//  ApiEndpoint+HTTPRequestBuilder.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 20.09.2021.
//

import Foundation
import RedmineApi
import HTTPClient
import Utils


extension Endpoint {
    func asHTTPRequest(domain: String) -> HTTPRequest {
        HTTPRequest(
            host: domain,

            path: path,

            method: conditional({
                switch method {
                case Endpoint.Method.get: return HTTPRequest.Method.get
                case Endpoint.Method.post: return HTTPRequest.Method.post
                case Endpoint.Method.delete: return HTTPRequest.Method.delete
                case Endpoint.Method.put: return HTTPRequest.Method.put
                }
            }),

            query: conditional({
                guard case let Endpoint.Task.query(dictionary) = task else {
                    return []
                }

                return dictionary.compactMap({
                    guard let value = $0.value else { return nil }

                    return HTTPRequest.Query(
                        key: $0.key,
                        value: String(describing: value)
                    )
                })
            }),

            headers: conditional({
                switch task {
                case Endpoint.Task.none, Endpoint.Task.query:
                    return [:]

                case Endpoint.Task.formData:
                    return ["Content-Type": "application/x-www-form-urlencoded; charset=utf-8"]

                case Endpoint.Task.json:
                    return ["Content-Type": "application/json"]
                }
            }),

            body: conditional({
                switch task {
                case Endpoint.Task.none, Endpoint.Task.query:
                    return .none

                case let Endpoint.Task.formData(dictionary):
                    return .formData(dictionary.removingOptionalValues())

                case let Endpoint.Task.json(dictionary):
                    return .json(dictionary.removingOptionalValues())
                }
            })
        )
    }
}

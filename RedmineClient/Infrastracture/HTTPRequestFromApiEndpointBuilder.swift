//
//  HTTPRequestFromApiEndpointBuilder.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 20.09.2021.
//

import Foundation
import RedmineApi
import HTTPClient
import Utils


extension Endpoint {
    enum HTTPRequestBuilderError: Error {
        case invalidJson(Error)
    }

    func asHTTPRequest(
        domain: String,
        credentials: Credentials = .none
    ) -> Result<HTTPRequest, HTTPRequestBuilderError> {
        Result<Data?, HTTPRequestBuilderError>.create({
            switch task {
            case Endpoint.Task.none, Endpoint.Task.query:
                return Result.success(nil)

            case let Endpoint.Task.formData(dictionary):
                return Result.success(
                    HTTPFormData(dictionary.compactMapValues({ $0 }))
                )

            case let Endpoint.Task.json(dictionary):
                return Result(catching: {
                    try JSONSerialization.data(
                        withJSONObject: dictionary.compactMapValues({ $0 }),
                        options: []
                    )
                })
                .mapError(HTTPRequestBuilderError.invalidJson)
            }
        })
        .map({ (body: Data?) in
            HTTPRequest(
                host: domain,

                path: self.path,

                method: conditional({
                    switch self.method {
                    case Endpoint.Method.get: return HTTPRequest.Method.get
                    case Endpoint.Method.post: return HTTPRequest.Method.post
                    case Endpoint.Method.delete: return HTTPRequest.Method.delete
                    case Endpoint.Method.put: return HTTPRequest.Method.put
                    }
                }),

                query: conditional({
                    guard case let Endpoint.Task.query(dictionary) = self.task else {
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
                    switch self.task {
                    case Endpoint.Task.none, Endpoint.Task.query:
                        return [:]

                    case Endpoint.Task.formData:
                        return ["Content-Type": "application/x-www-form-urlencoded; charset=utf-8"]

                    case Endpoint.Task.json:
                        return ["Content-Type": "application/json"]
                    }
                }),

                body: body
            )
        })
    }
}

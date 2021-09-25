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
    enum HTTPRequestBuilderError: Error {
        case invalidJson(Error)
    }

    func asHTTPRequest(domain: String) -> Result<HTTPRequest, HTTPRequestBuilderError> {
        let body: Data?

        switch task {
        case Endpoint.Task.none, Endpoint.Task.query:
            body = nil

        case let Endpoint.Task.formData(dictionary):
            body = HTTPFormData(dictionary.compactMapValues({ $0 }))

        case let Endpoint.Task.json(dictionary):
            do {
                body = try JSONSerialization.data(
                    withJSONObject: dictionary.compactMapValues({ $0 }),
                    options: []
                )
            } catch {
                return Result.failure(HTTPRequestBuilderError.invalidJson(error))
            }
        }

        let request = HTTPRequest(
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

        return Result.success(request)
    }
}

extension HTTPRequest {
    func authorized(with credentials: AuthorizationCredentials) -> Self {
        HTTPRequest(
            host: host,
            path: path,
            method: method,
            query: query,
            headers: conditional({
                var headers = self.headers

                switch credentials {
                case let AuthorizationCredentials.apiKey(apiKey):
                    headers["X-Redmine-API-Key"] = apiKey

                case let AuthorizationCredentials.basic(login: login, password: password):
                    let token = [login, password]
                        .joined(separator: ":")
                        .data(using: String.Encoding.utf8)!
                        .base64EncodedString()

                    headers["Authorization"] = "Basic \(token)"
                }

                return headers
            }),
            body: body
        )
    }
}

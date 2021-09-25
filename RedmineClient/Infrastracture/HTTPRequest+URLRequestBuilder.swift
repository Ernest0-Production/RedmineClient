//
//  HTTPRequest+URLRequestBuilder.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 20.09.2021.
//

import Foundation
import HTTPClient
import Utils


extension HTTPRequest {
    enum URLRequestBuilderError: Error {
        case invalidURL
    }

    func asURLRequest() -> Result<URLRequest, URLRequestBuilderError> {
        var components = URLComponents()

        components.scheme = "http"
        components.host = host
        components.path = path
        components.queryItems = query.map({
            URLQueryItem(name: $0.key, value: $0.value)
        })

        guard let url = components.url else {
            return Result.failure(URLRequestBuilderError.invalidURL)
        }

        var request = URLRequest(url: url)

        request.httpMethod = conditional({
            switch method {
            case HTTPRequest.Method.get: return "GET"
            case HTTPRequest.Method.post: return "POST"
            case HTTPRequest.Method.delete: return "DELETE"
            case HTTPRequest.Method.put: return "PUT"
            }
        })

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        request.httpBody = body

        return Result.success(request)
    }
}

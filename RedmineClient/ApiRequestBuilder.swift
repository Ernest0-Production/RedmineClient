//
//  ApiRequestBuilder.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 18.09.2021.
//

import Foundation


func buildApiRequest(
    domain: String,
    credentials: ApiCredentials,
    endpoint: ApiEndpoint
) -> URLRequest {
    fatalError()
}

enum ApiCredentials {
    case basic(login: String, password: String)
    case apiKey(String)
}

enum ApiEndpoint {
    case projects
}

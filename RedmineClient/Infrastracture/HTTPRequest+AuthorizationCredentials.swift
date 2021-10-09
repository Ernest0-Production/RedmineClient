//
//  HTTPRequest+AuthorizationCredentials.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 09.10.2021.
//

import Foundation
import RedmineApi
import HTTPClient
import Utils


extension HTTPRequest {
    func authorized(with credentials: AuthorizationCredentials) -> Self {
        switch credentials {
        case let AuthorizationCredentials.apiKey(apiKey):
            return settingHeader(name: "X-Redmine-API-Key", value: apiKey)

        case let AuthorizationCredentials.basic(login: login, password: password):
            let token = [login, password]
                .joined(separator: ":")
                .data(using: String.Encoding.utf8)!
                .base64EncodedString()

            return settingHeader(name: "Authorization", value: "Basic \(token)")
        }
    }
}

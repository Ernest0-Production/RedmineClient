//
//  ApiCredentials.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 19.09.2021.
//

enum ApiCredentials {
    case none
    case basic(login: String, password: String)
    case apiKey(String)
}

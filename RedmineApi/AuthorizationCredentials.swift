//
//  AuthorizationCredentials.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 19.09.2021.
//

public enum AuthorizationCredentials {
    case basic(login: String, password: String)
    case apiKey(String)
}

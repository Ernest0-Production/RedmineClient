//
//  Credentials.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 19.09.2021.
//

public enum Credentials {
    case none
    case basic(login: String, password: String)
    case apiKey(String)
}

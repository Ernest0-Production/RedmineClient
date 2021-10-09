//
//  HTTPRequestSendingError.swift
//  HTTPClient
//
//  Created by Ernest Babayan on 24.09.2021.
//

public enum HTTPRequestSendingError: Error {
    case invalidRequest(Error)
    case invalidResponse(Error)
}

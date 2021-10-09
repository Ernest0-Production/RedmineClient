//
//  HTTPRequestSending.swift
//  HTTPClient
//
//  Created by Ernest Babayan on 22.09.2021.
//

import Combine

// MARK: - Data

public typealias HTTPDataResponse = HTTPResponse<Data?>

public typealias HTTPDataTaskPublisher = AnyPublisher<HTTPDataResponse, HTTPRequestSendingError>

public typealias HTTPDataRequestSending = (HTTPRequest) -> HTTPDataTaskPublisher

// MARK: - Download

public typealias HTTPDownloadResponse = HTTPResponse<URL>

public typealias HTTPDownloadTaskPublisher = AnyPublisher<HTTPDownloadResponse, HTTPRequestSendingError>

public typealias HTTPDownloadRequestSending = (HTTPRequest) -> HTTPDownloadTaskPublisher

// MARK: - Upload

#warning("TODO Upload Request sending")

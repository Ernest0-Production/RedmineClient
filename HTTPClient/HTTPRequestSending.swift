//
//  HTTPRequestSending.swift
//  HTTPClient
//
//  Created by Ernest Babayan on 22.09.2021.
//

import Utils

public typealias HTTPRequestSending = (HTTPRequest, HTTPConnectionMode) -> DeferredFuture<HTTPResponse, HTTPRequestSendingError>

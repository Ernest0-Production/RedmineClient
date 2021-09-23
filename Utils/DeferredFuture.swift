//
//  DeferredFuture.swift
//  Utils
//
//  Created by Ernest Babayan on 24.09.2021.
//

import Combine


public typealias DeferredFuture<Output, Failure: Error> = Deferred<Future<Output, Failure>>

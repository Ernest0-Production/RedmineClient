//
//  URLSession+Combine.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 25.09.2021.
//

import Combine
import Foundation


extension URLSession {
    enum TaskError: Error {
        case sessionNotFound
        case invalidResponse
    }

    typealias DownloadTaskPublisher = AnyPublisher<(url: URL, response: URLResponse), Error>

    func downloadTaskPublisher(for request: URLRequest) -> DownloadTaskPublisher {
        Deferred<DownloadTaskPublisher> { [weak self] in
            var task: URLSessionTask?

            return Future<(url: URL, response: URLResponse), Error> { [weak self] promise in
                guard let self = self else {
                    promise(Result.failure(TaskError.sessionNotFound))
                    return
                }

                task = self.downloadTask(with: request) { url, response, error in
                    if let error = error {
                        promise(Result.failure(error))
                        return
                    }

                    guard
                        let url = url,
                        let response = response
                    else {
                        promise(Result.failure(TaskError.invalidResponse))
                        return
                    }

                    promise(.success((url: url, response: response)))
                }
            }
            .handleEvents(
                receiveSubscription: { _ in task?.resume() },
                receiveCancel: { task?.cancel() }
            )
            .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }

    typealias UploadTaskPublisher = AnyPublisher<(data: Data?, response: URLResponse), Error>

    func uploadTaskPublisher(for request: URLRequest, from bodyData: Data) -> UploadTaskPublisher {
        Deferred<UploadTaskPublisher> { [weak self] in
            var task: URLSessionTask?

            return Future<(data: Data?, response: URLResponse), Error> { [weak self] promise in
                guard let self = self else {
                    promise(Result.failure(TaskError.sessionNotFound))
                    return
                }

                task = self.uploadTask(with: request, from: bodyData) { data, response, error in
                    if let error = error {
                        promise(Result.failure(error))
                        return
                    }

                    guard let response = response else {
                        promise(Result.failure(TaskError.invalidResponse))
                        return
                    }

                    promise(.success((data: data, response: response)))
                }
            }
            .handleEvents(
                receiveSubscription: { _ in task?.resume() },
                receiveCancel: { task?.cancel() }
            )
            .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }

    func uploadTaskPublisher(for request: URLRequest, fromFile fileURL: URL) -> UploadTaskPublisher {
        Deferred<UploadTaskPublisher> { [weak self] in
            var task: URLSessionTask?

            return Future<(data: Data?, response: URLResponse), Error> { [weak self] promise in
                guard let self = self else {
                    promise(Result.failure(TaskError.sessionNotFound))
                    return
                }

                task = self.uploadTask(with: request, fromFile: fileURL) { data, response, error in
                    if let error = error {
                        promise(Result.failure(error))
                        return
                    }

                    guard let response = response else {
                        promise(Result.failure(TaskError.invalidResponse))
                        return
                    }

                    promise(.success((data: data, response: response)))
                }

                task?.resume()
            }
            .handleEvents(
                receiveSubscription: { _ in task?.resume() },
                receiveCancel: { task?.cancel() }
            )
            .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

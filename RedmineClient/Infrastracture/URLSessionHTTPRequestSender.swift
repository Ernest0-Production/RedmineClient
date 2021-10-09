//
//  URLSessionHTTPRequestSender.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 25.09.2021.
//

import HTTPClient
import Combine
import Utils


private struct IncorrectURLResponseTypeError: Error {}

func URLSessionHTTPDataRequestSender(session: URLSession = .shared) -> HTTPDataRequestSending {
    return { (httpRequest: HTTPRequest) -> HTTPDataTaskPublisher in
        let urlRequest: URLRequest

        do {
            urlRequest = try httpRequest.asURLRequest().get()
        } catch {
            return Fail(error: HTTPRequestSendingError.invalidRequest(error)).eraseToAnyPublisher()
        }

        return session
            .dataTaskPublisher(for: urlRequest)
            .mapError(HTTPRequestSendingError.invalidResponse)
            .flatMap({ (data: Data, response: URLResponse) -> HTTPDataTaskPublisher in

                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(
                        error: HTTPRequestSendingError.invalidResponse(IncorrectURLResponseTypeError())
                    ).eraseToAnyPublisher()
                }

                return Just(HTTPResponse(
                    statusCode: HTTPStatusCode(httpResponse.statusCode),
                    headers: HTTPHeaders(httpResponse.allHeaderFields),
                    body: data
                ))
                .setFailureType(to: HTTPRequestSendingError.self)
                .eraseToAnyPublisher()
            })
            .eraseToAnyPublisher()
    }
}

func URLSessionHTTPDownloadRequestSender(
    session: URLSession = .shared,
    fileManager: FileManager = .default
) -> HTTPDownloadRequestSending {
    return { (httpRequest: HTTPRequest) -> HTTPDownloadTaskPublisher in
        let urlRequest: URLRequest

        do {
            urlRequest = try httpRequest.asURLRequest().get()
        } catch {
            return Fail(error: HTTPRequestSendingError.invalidRequest(error)).eraseToAnyPublisher()
        }

        return session
            .downloadTaskPublisher(for: urlRequest)
            .mapError(HTTPRequestSendingError.invalidResponse)
            .flatMap({ (tempUrl: URL, response: URLResponse) -> HTTPDownloadTaskPublisher in

                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(
                        error: HTTPRequestSendingError.invalidResponse(IncorrectURLResponseTypeError())
                    ).eraseToAnyPublisher()
                }

                return Just(HTTPResponse(
                    statusCode: HTTPStatusCode(httpResponse.statusCode),
                    headers: HTTPHeaders(httpResponse.allHeaderFields),
                    body: tempUrl
                ))
                .setFailureType(to: HTTPRequestSendingError.self)
                .eraseToAnyPublisher()
            })
            .eraseToAnyPublisher()
    }
}

private func HTTPHeaders(_ raw: [AnyHashable: Any]) -> [String: String] {
    raw.reduce(into: [String: String](), { dict, pair in
        dict[String(describing: pair.key)] = String(describing: pair.value)
    })
}


//
//  HTTPRequestBody+JSON.swift
//  HTTPClient
//
//  Created by Ernest Babayan on 09.10.2021.
//

public extension HTTPRequest.Body {
    static func json(_ dictionary: [String: Any]) -> Self? {
        let data = try? JSONSerialization.data(
            withJSONObject: dictionary.compactMapValues({ $0 }),
            options: []
        )

        return data.map(HTTPRequest.Body.init)
    }
}

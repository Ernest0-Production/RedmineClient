//
//  HTTPFormData.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 20.09.2021.
//

import Foundation


public func HTTPFormData(_ parameters: [String: Any]) -> Data {
    func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        func escape(_ string: String) -> String {
            string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? string
        }

        var components: [(String, String)] = []

        switch value {
        case let dictionary as [String: Any]:
            components += dictionary.flatMap({
                queryComponents(fromKey: "\(key)[\($0.key)]", value: $0.value)
            })

        case let array as [Any]:
            components += array.flatMap({
                queryComponents(fromKey: "\(key)[]", value: $0)
            })

        case let bool as Bool:
            components.append((escape(key), escape(String(bool))))

        case let number as NSNumber:
            components.append((escape(key), escape(String(describing: number))))

        default:
            components.append((escape(key), escape("\(value)")))
       }

       return components
    }

    let query = parameters
        .lazy
        .flatMap(queryComponents)
        .map({ "\($0.0)=\($0.1)" })
        .joined(separator: "&")
        .utf8

    return Data(query)
}

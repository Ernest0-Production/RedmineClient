//
//  Identifier.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 19.09.2021.
//

import Foundation


public protocol IdentifiableObject {
    associatedtype RawIdentifier: Hashable = String

    typealias ID = Identifier<Self>

    var id: ID { get }
}

public struct Identifier<Entity: IdentifiableObject> {
    public let rawValue: Entity.RawIdentifier

    init(rawValue: Entity.RawIdentifier) {
        self.rawValue = rawValue
    }
}

extension Identifier: CustomStringConvertible {
    public var description: String { String(describing: rawValue) }
}

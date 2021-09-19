//
//  ID.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 19.09.2021.
//

import Foundation


protocol IdentifiableObject {
    associatedtype RawIdentifier: Hashable = String

    typealias ID = Identifier<Self>

    var id: ID { get }
}

struct Identifier<Entity: IdentifiableObject> {
    let rawValue: Entity.RawIdentifier

    init(rawValue: Entity.RawIdentifier) {
        self.rawValue = rawValue
    }
}

extension Identifier: CustomStringConvertible {
    var description: String { String(describing: rawValue) }
}

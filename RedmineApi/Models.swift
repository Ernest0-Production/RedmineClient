//
//  Models.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 19.09.2021.
//

import Utils


public struct Project: IdentifiableObject { public let id: ID }

public struct Tracker: IdentifiableObject { public let id: ID }

public struct Issue: IdentifiableObject {
    public let id: ID

    public struct Status: IdentifiableObject { public let id: ID }

    public struct Priority: IdentifiableObject { public let id: ID }

    public struct Category: IdentifiableObject { public let id: ID }
}


public struct User: IdentifiableObject {
    public let id: ID

    public struct Role: IdentifiableObject { public let id: ID }
}

public enum CreatedUserPassword {
    case custom(String)
    case generated

    var value: String? {
        switch self {
        case CreatedUserPassword.custom(let value):
            return value
        case CreatedUserPassword.generated:
            return nil
        }
    }

    var isGenerated: Bool {
        switch self {
        case CreatedUserPassword.custom:
            return false
        case CreatedUserPassword.generated:
            return true
        }
    }
}

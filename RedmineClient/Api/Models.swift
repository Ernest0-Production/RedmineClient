//
//  Models.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 19.09.2021.
//

struct Project: IdentifiableObject { let id: ID }

struct Tracker: IdentifiableObject { let id: ID }

struct Issue: IdentifiableObject {
    let id: ID

    struct Status: IdentifiableObject { let id: ID }

    struct Priority: IdentifiableObject { let id: ID }

    struct Category: IdentifiableObject { let id: ID }
}


struct User: IdentifiableObject {
    let id: ID

    struct Role: IdentifiableObject { let id: ID }
}

enum CreatedUserPassword {
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

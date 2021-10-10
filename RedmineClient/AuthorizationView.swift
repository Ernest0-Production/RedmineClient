//
//  AuthorizationView.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 10.10.2021.
//

import SwiftUI

struct AuthorizationView: View {
    init(
        authorizationTypes: [AuthorizationType],
        initialValue: AuthorizationType,
        contentView: @escaping (AuthorizationType) -> AnyView
    ) {
        self.authorizationTypes = authorizationTypes
        _selectedAuthorizationType = .init(initialValue: initialValue)
        self.contentView = contentView
    }

    private let authorizationTypes: [AuthorizationType]

    @State
    private var selectedAuthorizationType: AuthorizationType

    private let contentView: (AuthorizationType) -> AnyView

    var body: some View {
        VStack {
            Picker("Autohiraztion type", selection: $selectedAuthorizationType) {
                ForEach(authorizationTypes, id: \.self) {
                    Text($0.localizedDescription)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(16)

            contentView(selectedAuthorizationType)
                .frame(maxHeight: .infinity)
        }
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        return AuthorizationView(
            authorizationTypes: [.apiKey, .loginPassword],
            initialValue: .apiKey,
            contentView: { type in
                switch type {
                case .apiKey:
                    return AnyView(
                        ApiKeyInputFormView()
                    )

                case .loginPassword:
                    return AnyView(Text(type.localizedDescription))
                }
            }
        )
    }
}

enum AuthorizationType {
    case apiKey
    case loginPassword
}

extension AuthorizationType {
    var localizedDescription: String {
        switch self {
        case .apiKey:
            return "API KEY"
        case .loginPassword:
            return "Логин/Пароль"
        }
    }
}

struct ApiKeyInputFormView: View {
    @State var apiKeyValue: String = ""

    var body: some View {
        TextField(
            "enter api-key...",
            text: $apiKeyValue
        )
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8).stroke(Color(UIColor.systemGray3), lineWidth: 1)
        )
        .padding()
    }
}

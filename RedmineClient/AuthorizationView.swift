//
//  AuthorizationView.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 10.10.2021.
//

import SwiftUI

struct AuthorizationView: View {
    init(strategies: [AuthorizationStrategyView]) {
        self.strategies = strategies
    }

    private let strategies: [AuthorizationStrategyView]

    @State
    private var selectedIndex: Int = 0

    @State
    private var host: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Host: ")
                    Spacer()
                    TextField("http://your.redmine.workspace.com...", text: $host)
                }.padding()

                Picker("Authorization type", selection: $selectedIndex) {
                    ForEach(0..<strategies.count) { index in
                        Text(strategies[index].title)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(16)

                Spacer()

                GeometryReader { geometry in
                    strategies[selectedIndex].contentView
                        .frame(width: geometry.size.width,
                               height: geometry.size.height,
                               alignment: .top)
                }
            }
            .navigationTitle("Authorization")
        }
    }
}

struct AuthorizationStrategyView {
    init<Content: View >(title: String, content: Content) {
        self.title = title
        self.contentView = AnyView(content)
    }

    let title: String
    let contentView: AnyView
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        return AuthorizationView(strategies: [
            AuthorizationStrategyView(
                title: "API KEY",
                content: APIKeyAuthorizationFormView()
            ),

            AuthorizationStrategyView(
                title: "ANOTHER WAY",
                content: Text("TODO").background(Color.red)
            ),
        ])
    }
}


struct APIKeyAuthorizationFormView: View {
    @State var value: String = ""

    var body: some View {
        VStack {
            TextField("Enter API-KEY...", text: $value)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8).stroke(Color(UIColor.systemGray3), lineWidth: 0.5)
                )
                .padding()

            Button("Enter", action: {
                
            })
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(8)
            .padding()
        }
    }
}

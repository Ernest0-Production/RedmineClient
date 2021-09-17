//
//  ContentView.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 10.09.2021.
//

import SwiftUI

struct ContentView: View {
    let items = [1,2,3]
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ForEach(Array(repeating: 100, count: 100), id: \.self, content: { (number: Int) in
                    Text(String(number))
                        .frame(minWidth: proxy.size.width)
                })
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

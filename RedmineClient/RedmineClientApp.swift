//
//  RedmineClientApp.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 10.09.2021.
//

import SwiftUI

@main
struct RedmineClientApp: App {
    init() {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useAll] // optional: restricts the units to MB only
        bcf.countStyle = .file


        let task = URLSession.shared.downloadTask(with: URL(string: "https://speed.hetzner.de/1GB.bin")!) { data, response, error in
            print(data!)
//            print(bcf.string(fromByteCount: Int64(data!.count)))
        }

        let observer = task.progress.observe(\.fractionCompleted, options: [.new]) { value, change in
            print(value.fractionCompleted)
        }

        task.resume()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

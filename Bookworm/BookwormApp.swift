//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Mohsin khan on 12/09/2025.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
        .modelContainer(for: Book.self)
    }
}

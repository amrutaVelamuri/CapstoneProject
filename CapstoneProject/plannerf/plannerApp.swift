//
//  plannerApp.swift
//  CapstoneProject
//
//  Created by Ámbar Aguilar Sánchez on 30/07/25.
//

import SwiftUI
import SwiftData

@main
struct plannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView2()
            ContentView()
        }
        .modelContainer(for: [plannerItem.self, ToDoItem.self, Card.self])
    }
}

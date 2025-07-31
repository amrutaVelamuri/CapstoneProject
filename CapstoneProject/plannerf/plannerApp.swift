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
<<<<<<< HEAD:CapstoneProject/plannerf/plannerApp.swift
            ContentView2()
                .modelContainer(for: plannerItem.self)
=======
            ContentView()
                .modelContainer(for: ToDoItem.self)
                .modelContainer(for: Card.self)
>>>>>>> main:CapstoneProject/CapstoneProjectApp.swift
        }
    }
}


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
            ContentView()
=======
            ContentView()
                .modelContainer(for: ToDoItem.self)
                .modelContainer(for: Card.self)
            PlannerView()
                .modelContainer(for: PlannerItem.self)
>>>>>>> main:CapstoneProject/CapstoneProjectApp.swift
        }
        .modelContainer(for: [plannerItem.self, ToDoItem.self, Card.self])
    }
}

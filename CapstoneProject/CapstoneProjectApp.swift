//
//  plannerApp.swift
//  CapstoneProject
//
//  Created by Ámbar Aguilar Sánchez on 30/07/25.
//
 amruta-dev

 main
import SwiftUI
import SwiftData

@main
struct plannerApp: App {
    var body: some Scene {
        WindowGroup {
 HEAD:CapstoneProject/plannerf/plannerApp.swift
            ContentView2()
            ContentView()

 main
            ContentView()
                .modelContainer(for: ToDoItem.self)
                .modelContainer(for: Card.self)
            PlannerView()
                .modelContainer(for: PlannerItem.self)
 amruta-dev
 main:CapstoneProject/CapstoneProjectApp.swift
        }
        .modelContainer(for: [plannerItem.self, ToDoItem.self, Card.self])
    }
}

        }
    }
}

 main

//
//  CapstoneProjectApp.swift
//  CapstoneProject
//
//  Created by Amruta Velamuri on 7/29/25.
//
import SwiftUI
import SwiftData

@main
struct plannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: plannerItem.self)
        }
    }
}


//
//  ContentView.swift
//  CapstoneProject
//
//  Created by Amruta Velamuri on 7/29/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack() {
                Color(hue: 0.078, saturation: 0.267, brightness: 0.537)
                    .ignoresSafeArea()
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Grade Savior")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    NavigationLink(destination: HomeScreenView()) {
                        Text("Start")
                            .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            .background(Color(hue: 0.119, saturation: 0.092, brightness: 1.0))
                            .cornerRadius(15)
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}

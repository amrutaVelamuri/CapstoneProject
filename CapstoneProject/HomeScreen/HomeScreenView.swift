//
//  HomeScreenView.swift
//  CapstoneProject
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hue: 0.119, saturation: 0.092, brightness: 1.0)
                    .ignoresSafeArea()
                VStack(spacing: -10) {
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 300.0)
                            .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                        HStack {
                            Text("To-Do List")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(Color(hue: 0.119, saturation: 0.092, brightness: 1.0))
                            Spacer()
                            NavigationLink(destination: ToDoList()) {
                                Text("See more")
                                    .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                                    .padding(8.0)
                                    .background(Color(hue: 0.119, saturation: 0.092, brightness: 1.0))
                                    .cornerRadius(10)
                                    .padding()
                            }
                        }
                    }
                    .padding()
                    .padding(.horizontal)
                    
                    VStack(spacing: -10) {
                        HStack(spacing: -10) {
                            NavigationLink(destination: FlashcardDeckView()) {
                                RoundedRectangle(cornerRadius: 20)
                                    .padding()
                                    .frame(height: 195.0)
                                    .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                            }
                            NavigationLink(destination: Text("Planner")) {
                                RoundedRectangle(cornerRadius: 20)
                                    .padding()
                                    .frame(height:195.0)
                                    .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: -10) {
                            NavigationLink(destination: Text("blank")) {
                                RoundedRectangle(cornerRadius: 20)
                                    .padding()
                                    .frame(height:195.0)
                                    .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                            }
                            NavigationLink(destination: Text("blank")) {
                                RoundedRectangle(cornerRadius: 20)
                                    .padding()
                                    .frame(height:195.0)
                                    .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                }
                
            }
        }
        
    }
}

#Preview {
    HomeScreenView()
}

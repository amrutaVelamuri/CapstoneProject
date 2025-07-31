//
//  HomeScreenView.swift
//  CapstoneProject
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI
import SwiftData

struct HomeScreenView: View {
    @Environment(\.modelContext) private var context
    @Query var toDos: [ToDoItem]
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
                        VStack {
                            HStack {
                                Text("To-Do List")
                                    .font(.title2)
                                    .fontWeight(.black)
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
                            /*List {
                                ForEach(sortToDos()) { toDoItem in HStack {
                                    if toDoItem.isImportant {
                                        Text("‼️" + toDoItem.title)
                                        .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                                    } else {
                                        Text(toDoItem.title)
                                        .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                                    }
                                    Spacer()
                                    Text(toDoItem.dueDate, format: .dateTime.month().day().year())
                                    .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423).opacity(0.8))
                                    }
                                    .padding()
                                    .background(Color(hue: 0.119, saturation: 0.092, brightness: 1.0))
                                    .cornerRadius(10)
                                }
                            }
                            .listStyle(.plain)
                            .background(Color.clear)
                             */
                        }
                    }
                    .padding()
                    .padding(.horizontal)
                    
                    VStack(spacing: -10) {
                        HStack(spacing: -10) {
                            NavigationLink(destination: FlashcardDeckView()) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .padding()
                                        .frame(height: 195.0)
                                        .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                                    Text("Flashcards")
                                        .font(.title3)
                                        .fontWeight(.black)
                                        .foregroundColor(Color.white)
                                }
                            }
                            NavigationLink(destination: PlannerView()) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .padding()
                                        .frame(height: 195.0)
                                        .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                                    Text("Planner")
                                        .font(.title3)
                                        .fontWeight(.black)
                                        .foregroundColor(Color.white)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: -10) {
                            NavigationLink(destination: PomodoroTimerView()) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .padding()
                                        .frame(height: 195.0)
                                        .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                                    VStack {
                                        Text("Pomodoro")
                                            .font(.title3)
                                            .fontWeight(.black)
                                            .foregroundColor(Color.white)
                                        Text("Timer")
                                            .font(.title3)
                                            .fontWeight(.black)
                                            .foregroundColor(Color.white)
                                    }
                                }
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
/*func sortToDos() -> [ToDoItem] {
    let sortedToDos = toDoList.toDos.sorted(by: {(s1: ToDoItem, s2: ToDoItem)
        -> Bool in return s1.dueDate > s2.dueDate})
    var topThreeToDos : [ToDoItem]
    if sortedToDos.count == 0 {
        return []
    } else if sortedToDos.count == 1 {
        topThreeToDos = [sortedToDos[0]]
    } else if sortedToDos.count == 2 {
        topThreeToDos = [sortedToDos[0], sortedToDos[1]]
    } else {
        topThreeToDos = [sortedToDos[0], sortedToDos[1], sortedToDos[2]]
    }
    return topThreeToDos
}
*/
#Preview {
    HomeScreenView()
}

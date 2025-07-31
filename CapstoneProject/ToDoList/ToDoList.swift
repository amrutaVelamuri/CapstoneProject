//
//  ToDoList.swift
//  CapstoneProject
//
//  Created by Ranjan Verma on 7/29/25.
//

import SwiftUI
import SwiftData
//Color(hue: 0.119, saturation: 0.092, brightness: 1.0)
//Color(hue: 0.079, saturation: 0.389, brightness: 0.423)
struct ToDoList: View {
    @State private var showNewTask = false
    @Query var toDos: [ToDoItem]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        ZStack {
            Color(hue: 0.079, saturation: 0.389, brightness: 0.423)
                .ignoresSafeArea()
            VStack {
                HStack() {
                    Text("To Do List")
                        .font(.system(size:40))
                        .fontWeight(.black)
                        .foregroundColor(Color(hue: 0.119, saturation: 0.092, brightness: 1.0))
                    
                    Spacer()
                    Button {
                        withAnimation {
                            showNewTask = true
                        }
                    } label: {
                        Text("+")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                        .padding(12)
                        .background(Color(hue: 0.119, saturation: 0.092, brightness: 1.0))
                        .cornerRadius(10)
                    }
                }
                .padding()
                Spacer()
                List {
                    ForEach(toDos) { toDoItem in
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
                        
                        .padding()
                        .background(Color(hue: 0.119, saturation: 0.092, brightness: 1.0))
                        .cornerRadius(10)
                    }
                    .onDelete(perform: deleteToDo)
                }
                .listStyle(.plain)
                .background(Color.white)
                if showNewTask {
                    NewToDo(showNewTask: $showNewTask, toDoItem: ToDoItem(title: "", isImportant: false, dueDate: Date.now))
                        .padding()
                        .background(
                            Rectangle()
                                .fill(Color(hue: 0.119, saturation: 0.092, brightness: 1.0))
                                .ignoresSafeArea()
                        )
                }
            }
        }
    }
    func deleteToDo(at offsets: IndexSet) {
        for offset in offsets {
            let toDoItem = toDos[offset]
            modelContext.delete(toDoItem)
        }
    }
}
//var toDoList = ToDoList()
#Preview {
    ToDoList()
        .modelContainer(for: ToDoItem.self, inMemory: true)
}

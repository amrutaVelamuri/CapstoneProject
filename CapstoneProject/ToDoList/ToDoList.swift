//
//  ToDoList.swift
//  CapstoneProject
//
//  Created by Ranjan Verma on 7/29/25.
//

import SwiftUI
import SwiftData

@Query var toDos: [ToDoItem]
struct ToDoList: View {
    @State private var showNewTask = false
    @Environment(\.modelContext) var modelContext
    var body: some View {
        ZStack {
            Color(hue: 0.119, saturation: 0.092, brightness: 1.0)
                .ignoresSafeArea()
            VStack {
                HStack() {
                    Text("To Do List")
                        .font(.system(size:40))
                        .fontWeight(.black)
                        .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                    
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
                        .padding(8)
                        .background(Color(hue: 0.119, saturation: 0.092, brightness: 1.0))
                        .cornerRadius(10)
                    }
                }
                .padding()
                Spacer()
                List {
                    ForEach(toDos) { toDoItem in HStack {
                        if toDoItem.isImportant {
                            Text("‼️" + toDoItem.title)
                            .foregroundColor(.white)
                        } else {
                            Text(toDoItem.title)
                            .foregroundColor(.white)
                        }
                        Spacer()
                        Text(toDoItem.dueDate, format: .dateTime.month().day().year())
                        .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                        .background(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                        .cornerRadius(10)
                    }
                    .onDelete(perform: deleteToDo)
                }
                .listStyle(.plain)
                .background(Color.clear)
                if showNewTask {
                    NewToDo(showNewTask: $showNewTask, toDoItem: ToDoItem(title: "", isImportant: false, dueDate: Date.now))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(hue: 0.079, saturation: 0.389, brightness: 0.423), lineWidth: 3)
                        )
                        .padding(.horizontal)
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

#Preview {
    ToDoList()
        .modelContainer(for: ToDoItem.self, inMemory: true)
}

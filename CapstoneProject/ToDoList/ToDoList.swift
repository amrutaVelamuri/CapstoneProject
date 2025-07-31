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
        VStack {
            HStack() {
                Text("To Do List")
                    .font(.system(size:40))
                    .fontWeight(.black)
                Spacer()
                Button {
                    withAnimation {
                        showNewTask = true
                    }
                } label: {
                    Text("+")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
        }
        .padding()
        Spacer()
        List {
            ForEach(toDos) { toDoItem in HStack {
                if toDoItem.isImportant {
                    Text("‼️" + toDoItem.title)
                } else {
                    Text(toDoItem.title)
                }
                Spacer()
                Text(toDoItem.dueDate, format: .dateTime.month().day().year())
                }
            }
            .onDelete(perform: deleteToDo)
        }
        .listStyle(.plain)
        
        if showNewTask {
            NewToDo(showNewTask: $showNewTask, toDoItem: ToDoItem(title: "", isImportant: false, dueDate: Date.now))
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

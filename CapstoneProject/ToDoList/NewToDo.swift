//
//  NewToDo.swift
//  CapstoneProject
//
//  Created by Ranjan Verma on 7/29/25.
//

import SwiftUI
import SwiftData

struct NewToDo: View {
    @Binding var showNewTask: Bool
    @Bindable var toDoItem: ToDoItem
    @Environment(\.modelContext) var modelContext
    var body: some View {
        VStack {
            Text("Task title:")
                .font(.title)
                .fontWeight(.bold)
            DatePicker(selection: $toDoItem.dueDate, in: Date.distantPast...Date.now, displayedComponents: .date){
                TextField("Enter the task description", text: $toDoItem.title, axis: .vertical)
                    .padding(7.0)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(8)
            }
            
            Toggle(isOn: $toDoItem.isImportant) {
                Text("Is it important?")
            }
            Button {
                addToDo()
                showNewTask = false
            } label: {
                Text("Save")
            }
        }
        .padding()
    }
    func addToDo() {
        let toDo = ToDoItem(title: toDoItem.title, isImportant: toDoItem.isImportant, dueDate: toDoItem.dueDate)
        modelContext.insert(toDo)
    }
}

#Preview {
    NewToDo(showNewTask: .constant(false), toDoItem: ToDoItem(title: "", isImportant: false, dueDate: Date.now))
}

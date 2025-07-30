//
//  Contentview.swift
//  CapstoneProject
//
//  Created by Ámbar Aguilar Sánchez on 30/07/25.
//
import SwiftUI
import SwiftData

struct ContentView2: View {
    @Query private var planner: [plannerItem]
    @Environment(\.modelContext) private var context
    @State private var newTask = ""
    @State private var newDate = Date.now

    var body: some View {
        ZStack {
            Color.brown.ignoresSafeArea()

            NavigationStack {
                List {
                    ForEach(planner) { item in
                        HStack {
                            Button {
                                item.isDone.toggle()
                            } label: {
                                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isDone ? .green : .white)
                            }

                            VStack(alignment: .leading) {
                                Text(item.task)
                                    .strikethrough(item.isDone)
                                    .foregroundColor(item.isDone ? .gray : .white)

                                Text(item.date, format: .dateTime.month(.wide).day().year())
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }

                            Spacer()
                        }
                        .padding()
                        .background(Color.brown)
                        .cornerRadius(10)
                    }
                    .onDelete(perform: deleteplannerItem)
                }
                .scrollContentBackground(.hidden)
                .padding(.horizontal)
                .navigationTitle("Planner! :)")

                .safeAreaInset(edge: .bottom) {
                    VStack(alignment: .center, spacing: 20) {
                        Text("New Task")
                            .font(.headline)
                            .foregroundColor(.white)

                        TextField("Task", text: $newTask)
                            .textFieldStyle(.roundedBorder)

                        DatePicker("Date", selection: $newDate, displayedComponents: .date)

                        Button("Save") {
                            guard !newTask.isEmpty else { return }
                            let newItem = plannerItem(task: newTask, date: newDate)
                            context.insert(newItem)
                            newTask = ""
                            newDate = .now
                        }
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                    .padding()
                    .background(Color.brown)
                }
            }
        }
    }

    func deleteplannerItem(at offsets: IndexSet) {
        for index in offsets {
            let itemToDelete = planner[index]
            context.delete(itemToDelete)
        }
    }
}

#Preview {
    ContentView2()
        .modelContainer(for: plannerItem.self, inMemory: true)
}


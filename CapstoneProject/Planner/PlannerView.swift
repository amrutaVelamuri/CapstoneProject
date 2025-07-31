//
//  Contentview.swift
//  CapstoneProject
//
//  Created by Ámbar Aguilar Sánchez on 30/07/25.
//
import SwiftUI
import SwiftData

struct PlannerView: View {
    @Query private var planner: [PlannerItem]
    @Environment(\.modelContext) private var context
    @State private var newTask = ""
    @State private var newDate = Date.now
    @State private var newTime = Date()

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
                                    .foregroundColor(item.isDone ? .yellow : .white)
                            }

                            VStack(alignment: .leading) {
                                Text(item.task)
                                    .strikethrough(item.isDone)
                                    .foregroundColor(item.isDone ? .white : .black)

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
                .padding(.bottom)
                .scrollContentBackground(.hidden)
                .background(Color(hue: 0.135, saturation: 0.29, brightness: 1.0))
                .navigationTitle("Planner!!")

                .safeAreaInset(edge: .bottom) {
                    VStack(alignment: .center, spacing: 20) {
                        Text("New Task")
                            .font(.headline)
                            .foregroundColor(.yellow)

                        TextField("Task", text: $newTask)
                            .textFieldStyle(.roundedBorder)

                        DatePicker("Date", selection: $newDate, displayedComponents: .date)
                            .foregroundColor(.yellow)
                        DatePicker("Hour", selection: $newTime, displayedComponents: .hourAndMinute)
                            .foregroundColor(.yellow)
                        

                        Button("Save") {
                            guard !newTask.isEmpty else { return }
                            let newItem = PlannerItem(task: newTask, date: newDate, time: newTime)
                            context.insert(newItem)
                            newTask = ""
                            newDate = .now
                        }
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
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
    PlannerView()
        .modelContainer(for: PlannerItem.self, inMemory: true)
}



import SwiftUI
import SwiftData

struct ContentView2: View {
    @Query private var planner: [plannerItem]
    @Environment(\.modelContext) private var context

    @State private var newTask = ""
    @State private var selectedDate = Date.now
    @State private var currentMonth: Date = Date.now

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CalendarHeader(currentMonth: $currentMonth)
                CalendarGrid(selectedDate: $selectedDate, currentMonth: $currentMonth, planner: planner)

                Text("Tasks for \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.headline)
                    .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                    .padding(.top)

                List {
                    ForEach(tasksForSelectedDate) { item in
                        HStack {
                            Button {
                                item.isDone.toggle()
                            } label: {
                                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isDone ? .white : Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
                            }

                            VStack(alignment: .leading) {
                                Text(item.task)
                                    .strikethrough(item.isDone)
                                    .foregroundColor(item.isDone ? .gray : .black)

                                Text(item.date.formatted(date: .abbreviated, time: .omitted))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let item = tasksForSelectedDate[index]
                            context.delete(item)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color(hue: 0.119, saturation: 0.092, brightness: 1.0))

                VStack(spacing: 12) {
                    Text("Add Task for \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
                        .font(.headline)
                        .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))

                    TextField("New task", text: $newTask)
                        .textFieldStyle(.roundedBorder)
                        .background(.white)

                    Button("Save") {
                        guard !newTask.isEmpty else { return }
                        let newItem = plannerItem(task: newTask, date: selectedDate)
                        context.insert(newItem)
                        newTask = ""
                    }
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hue: 0.079, saturation: 0.389, brightness: 0.423)) // dark green
                    .cornerRadius(10)
                    .foregroundColor(Color(hue: 0.119, saturation: 0.092, brightness: 1.0)) // yellowish
                }
                .padding()
            }
            .padding()
            .background(Color(hue: 0.119, saturation: 0.092, brightness: 1.0).ignoresSafeArea())
            .navigationTitle("Planner Calendar")
        }
    }

    var tasksForSelectedDate: [plannerItem] {
        planner.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
}

struct CalendarHeader: View {
    @Binding var currentMonth: Date

    var body: some View {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentMonth)
        let month = components.month ?? 1
        let year = components.year ?? 2024

        HStack {
            Button {
                currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
            }

            Spacer()

            Text("\(calendar.monthSymbols[month - 1]) \(year)")
                .font(.title2)
                .bold()
                .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))

            Spacer()

            Button {
                currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
            }
        }
        .padding(.horizontal)
    }
}

struct CalendarGrid: View {
    @Binding var selectedDate: Date
    @Binding var currentMonth: Date
    let planner: [plannerItem]

    let calendar = Calendar.current
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        let numDays = range.count
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let offset = firstWeekday - calendar.firstWeekday

        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .font(.subheadline)
                    .foregroundColor(Color(hue: 0.079, saturation: 0.389, brightness: 0.423))
            }

            ForEach(0..<(offset < 0 ? offset + 7 : offset), id: \.self) { _ in
                Text("").frame(height: 30)
            }

            ForEach(1...numDays, id: \.self) { day in
                let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)!
                let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
                let hasTasks = planner.contains { calendar.isDate($0.date, inSameDayAs: date) }

                Text("\(day)")
                    .frame(maxWidth: .infinity, minHeight: 30)
                    .padding(8)
                    .background(
                        isSelected ? Color(hue: 0.079, saturation: 0.389, brightness: 0.423) :
                        (hasTasks ? Color.black.opacity(0.1) : Color.clear)
                    )
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedDate = date
                    }
                    .foregroundColor(isSelected ? Color(hue: 0.119, saturation: 0.092, brightness: 1.0) : .black)
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    ContentView2()
        .modelContainer(for: plannerItem.self, inMemory: true)
}

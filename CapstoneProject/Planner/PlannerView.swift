import SwiftUI
import SwiftData

struct PlannerView: View {
    @Query private var planner: [PlannerItem]
    @Environment(\.modelContext) private var context

    @State private var newTask = ""
    @State private var selectedDate = Date.now
    @State private var currentMonth: Date = Date.now
    @State private var newDate = Date.now
    @State private var newTime = Date()

    let paleYellow = Color(hue: 0.119, saturation: 0.092, brightness: 1.0)
    let brown = Color(hue: 0.079, saturation: 0.389, brightness: 0.423)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    CalendarHeader(currentMonth: $currentMonth, brown: brown)
                    CalendarGrid(
                        selectedDate: $selectedDate,
                        currentMonth: $currentMonth,
                        planner: planner,
                        paleYellow: paleYellow,
                        brown: brown
                    )

                    Text("Tasks for \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
                        .font(.headline)
                        .foregroundColor(brown)
                        .padding(.top)

                    VStack(spacing: 10) {
                        ForEach(tasksForSelectedDate) { item in
                            HStack {
                                Button {
                                    item.isDone.toggle()
                                } label: {
                                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(item.isDone ? paleYellow : .white)
                                }

                                VStack(alignment: .leading) {
                                    Text(item.task)
                                        .strikethrough(item.isDone)
                                        .foregroundColor(item.isDone ? .gray : .black)

                                    Text(item.date.formatted(date: .abbreviated, time: .omitted))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)

                    Divider()
                        .padding(.vertical)

                    VStack(alignment: .center, spacing: 20) {
                        Text("New Task")
                            .font(.headline)
                            .foregroundColor(paleYellow)

                        TextField("Task", text: $newTask)
                            .textFieldStyle(.roundedBorder)

                        VStack(alignment: .leading) {
                            Text("Date")
                                .foregroundColor(paleYellow)
                            DatePicker("", selection: $newDate, displayedComponents: .date)
                                .labelsHidden()
                                .foregroundColor(paleYellow)
                        }

                        VStack(alignment: .leading) {
                            Text("Hour")
                                .foregroundColor(paleYellow)
                            DatePicker("", selection: $newTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .foregroundColor(paleYellow)
                        }

                        Button("Save") {
                            guard !newTask.isEmpty else { return }
                            let newItem = PlannerItem(task: newTask, date: newDate, time: newTime)
                            context.insert(newItem)
                            newTask = ""
                            newDate = .now
                            newTime = .now
                        }
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                    }
                    .padding()
                    .background(brown)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .background(paleYellow.ignoresSafeArea())
            .navigationTitle("Planner")
        }
    }

    var tasksForSelectedDate: [PlannerItem] {
        planner.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }

    func deleteplannerItem(at offsets: IndexSet) {
        for index in offsets {
            let itemToDelete = planner[index]
            context.delete(itemToDelete)
        }
    }
}

struct CalendarHeader: View {
    @Binding var currentMonth: Date
    let brown: Color

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
                    .foregroundColor(brown)
            }

            Spacer()

            Text("\(calendar.monthSymbols[month - 1]) \(year)")
                .font(.title2)
                .bold()
                .foregroundColor(brown)

            Spacer()

            Button {
                currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(brown)
            }
        }
        .padding(.horizontal)
    }
}

struct CalendarGrid: View {
    @Binding var selectedDate: Date
    @Binding var currentMonth: Date
    let planner: [PlannerItem]
    let paleYellow: Color
    let brown: Color

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
                    .foregroundColor(brown)
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
                        isSelected ? brown :
                            (hasTasks ? Color.black.opacity(0.1) : Color.clear)
                    )
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedDate = date
                    }
                    .foregroundColor(isSelected ? paleYellow : .black)
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    PlannerView()
        .modelContainer(for: PlannerItem.self, inMemory: true)
}

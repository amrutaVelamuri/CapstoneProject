import SwiftUI

struct PomodoroTimerView: View {
    @State private var timeRemaining = 25 * 60
    @State private var timerRunning = false
    @State private var isWorkSession = true

    private let workDuration = 25 * 60
    private let breakDuration = 5 * 60

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    let cardColor = Color(hue: 0.079, saturation: 0.389, brightness: 0.423)
    let backgroundColor = Color(hue: 0.119, saturation: 0.092, brightness: 1.0)

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Pomodoro Timer")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(cardColor)

                Text(isWorkSession ? "Focus Time" : "Break Time")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(cardColor)

                Text(formatTime(timeRemaining))
                    .font(.system(size: 48, design: .monospaced))
                    .padding()
                    .frame(width: 200, height: 200)
                    .background(cardColor)
                    .foregroundColor(backgroundColor)
                    .clipShape(Circle())
                    .shadow(radius: 10)

                HStack(spacing: 40) {
                    Button(timerRunning ? "Pause" : "Start") {
                        timerRunning.toggle()
                    }
                    .font(.headline)
                    .padding()
                    .frame(width: 100)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)

                    Button("Reset") {
                        resetTimer()
                    }
                    .font(.headline)
                    .padding()
                    .frame(width: 100)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                }
            }
            .padding()
        }
        .onReceive(timer) { _ in
            guard timerRunning else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isWorkSession.toggle()
                timeRemaining = isWorkSession ? workDuration : breakDuration
                timerRunning = false
            }
        }
    }

    func resetTimer() {
        timerRunning = false
        timeRemaining = isWorkSession ? workDuration : breakDuration
    }

    func formatTime(_ seconds: Int) -> String {
        String(format: "%02d:%02d", seconds / 60, seconds % 60)
    }
}

#Preview {
    PomodoroTimerView()
}

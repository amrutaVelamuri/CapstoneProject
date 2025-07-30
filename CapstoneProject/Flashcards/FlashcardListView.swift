import SwiftUI
import SwiftData

struct FlashcardListView: View {
    @Environment(\.modelContext) private var context
    @Binding var showNewFlashcard: Bool

    @State private var question = ""
    @State private var answer = ""

    // Theme colors
    let brownColor = Color(hue: 0.079, saturation: 0.389, brightness: 0.423)
    let yellowBackground = Color(hue: 0.119, saturation: 0.092, brightness: 1.0)

    var body: some View {
        VStack {
            Text("New Flashcard")
                .font(.title)
                .fontWeight(.bold)

            ZStack(alignment: .leading) {
                if question.isEmpty {
                    Text("Enter the question")
                        .foregroundColor(yellowBackground)
                        .padding(.horizontal, 16)
                }
                TextField("", text: $question)
                    .padding()
                    .foregroundColor(.white)
            }
            .background(brownColor)
            .cornerRadius(15)
            .padding(.horizontal)

            ZStack(alignment: .leading) {
                if answer.isEmpty {
                    Text("Enter the answer")
                        .foregroundColor(yellowBackground)
                        .padding(.horizontal, 16)
                }
                TextField("", text: $answer)
                    .padding()
                    .foregroundColor(.white)
            }
            .background(brownColor)
            .cornerRadius(15)
            .padding(.horizontal)

            Button {
                addFlashcard()
                showNewFlashcard = false
            } label: {
                Text("Save")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(brownColor)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding()
        }
        .padding()
        .background(yellowBackground.ignoresSafeArea())
    }

    func addFlashcard() {
        let newCard = Card(question: question, answer: answer)
        context.insert(newCard)
    }
}

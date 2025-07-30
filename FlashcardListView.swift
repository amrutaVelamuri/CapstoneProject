import SwiftUI
import SwiftData

struct FlashcardListView: View {
    @Environment(\.modelContext) private var context
    @Binding var showNewFlashcard: Bool

    @State private var question = ""
    @State private var answer = ""

    let cardColor = Color(hue: 0.079, saturation: 0.389, brightness: 0.423) // brown
    let backgroundColor = Color(hue: 0.119, saturation: 0.092, brightness: 1.0) // yellow

    var body: some View {
        VStack {
            Text("New Flashcard")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)

            ZStack(alignment: .leading) {
                if question.isEmpty {
                    Text("Enter the question")
                        .foregroundColor(backgroundColor)
                        .padding(.horizontal, 16)
                }
                TextField("", text: $question)
                    .padding()
                    .foregroundColor(.white)
            }
            .background(cardColor)
            .cornerRadius(15)
            .padding(.horizontal)

            ZStack(alignment: .leading) {
                if answer.isEmpty {
                    Text("Enter the answer")
                        .foregroundColor(backgroundColor)
                        .padding(.horizontal, 16)
                }
                TextField("", text: $answer)
                    .padding()
                    .foregroundColor(.white)
            }
            .background(cardColor)
            .cornerRadius(15)
            .padding(.horizontal)

            // Save button
            Button {
                addFlashcard()
                showNewFlashcard = false
            } label: {
                Text("Save")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding()
        }
        .padding()
        .background(backgroundColor)
        .ignoresSafeArea(edges: .bottom)
    }

    func addFlashcard() {
        let newCard = Card(question: question, answer: answer)
        context.insert(newCard)
    }
}

import SwiftUI
import SwiftData

struct FlashcardListView: View {
    @Environment(\.modelContext) private var context
    @Binding var showNewFlashcard: Bool

    @State private var question = ""
    @State private var answer = ""

    var body: some View {
        VStack {
            Text("New Flashcard")
                .font(.title)
                .fontWeight(.bold)

            TextField("Enter the question", text: $question)
                .padding()
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)
                .padding(.horizontal)

            TextField("Enter the answer", text: $answer)
                .padding()
                .background(Color(.systemGroupedBackground))
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
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding()
        }
        .padding()
    }

    func addFlashcard() {
        let newCard = Card(question: question, answer: answer)
        context.insert(newCard) 
    }
}

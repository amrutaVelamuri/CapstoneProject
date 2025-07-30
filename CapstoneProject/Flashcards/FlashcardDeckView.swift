import SwiftUI
import SwiftData

struct FlashcardDeckView: View {
    @Environment(\.modelContext) private var context
    @Query private var cards: [Card]

    @State private var currentIndex = 0
    @State private var showNewFlashcard = false

    // Theme colors
    let backgroundColor = Color(hue: 0.119, saturation: 0.092, brightness: 1.0)  // pale yellow
    let cardColor = Color(hue: 0.079, saturation: 0.389, brightness: 0.423)       // brown

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                if cards.isEmpty {
                    Text("No flashcards yet.")
                        .font(.title2)
                        .foregroundColor(.gray)
                } else {
                    Flashcards(card: cards[currentIndex])
                        .background(cardColor)
                        .cornerRadius(20)
                        .padding()
                    
                    HStack {
                        Button(action: {
                            if currentIndex > 0 {
                                currentIndex -= 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(cardColor)
                        }
                        .disabled(currentIndex == 0)

                        Spacer()

                        Button(role: .destructive) {
                            deleteCard(at: IndexSet(integer: currentIndex))
                        } label: {
                            Image(systemName: "trash")
                                .font(.title2)
                                .foregroundStyle(.red)
                        }

                        Spacer()

                        Button(action: {
                            if currentIndex < cards.count - 1 {
                                currentIndex += 1
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.title2)
                                .foregroundColor(cardColor)
                        }
                        .disabled(currentIndex == cards.count - 1)
                    }
                    .padding(.horizontal, 40)

                    Text("Card \(currentIndex + 1) of \(cards.count)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .padding()
            .background(backgroundColor.ignoresSafeArea())
            .navigationTitle("Flashcards")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewFlashcard = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(cardColor)
                    }
                }
            }
            .sheet(isPresented: $showNewFlashcard, onDismiss: {
                if currentIndex >= cards.count {
                    currentIndex = max(0, cards.count - 1)
                }
            }) {
                FlashcardListView(showNewFlashcard: $showNewFlashcard)
            }
        }
    }

    func deleteCard(at offsets: IndexSet) {
        for offset in offsets {
            let card = cards[offset]
            context.delete(card)
        }
        if currentIndex >= cards.count - 1 {
            currentIndex = max(0, currentIndex - 1)
        }
    }
}

#Preview {
    do {
        let container = try ModelContainer(
            for: Card.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )

        let context = container.mainContext
        context.insert(Card(question: "What is the capital of France?", answer: "Paris"))
        context.insert(Card(question: "What is 9 × 6?", answer: "54"))

        return FlashcardDeckView()
            .modelContainer(container)
    } catch {
        return Text("Preview Error: \(error.localizedDescription)")
    }
}

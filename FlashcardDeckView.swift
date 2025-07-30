import SwiftUI
import SwiftData

struct FlashcardDeckView: View {
    @Environment(\.modelContext) private var context
    @Query private var cards: [Card]

    @State private var currentIndex = 0
    @State private var showNewFlashcard = false

    let backgroundColor = Color(hue: 0.119, saturation: 0.092, brightness: 1.0)
    let cardColor = Color(hue: 0.079, saturation: 0.389, brightness: 0.423)

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()

                VStack(spacing: 24) {
                    if cards.isEmpty {
                        Text("No flashcards yet.")
                            .font(.title2)
                            .foregroundColor(.gray)
                    } else {
                        Flashcards(card: cards[currentIndex]) // ✅ your flipping view

                        HStack {
                            Button {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.title2)
                                    .foregroundColor(.primary)
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

                            Button {
                                if currentIndex < cards.count - 1 {
                                    currentIndex += 1
                                }
                            } label: {
                                Image(systemName: "chevron.right")
                                    .font(.title2)
                                    .foregroundColor(.primary)
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
    let container = try! ModelContainer(
        for: Card.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext
    context.insert(Card(question: "What is the capital of France?", answer: "Paris"))
    context.insert(Card(question: "What is 9 × 6?", answer: "54"))

    return FlashcardDeckView().modelContainer(container)
}

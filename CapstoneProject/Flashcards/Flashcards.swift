import SwiftUI

struct Flashcards: View {
    @State private var isFlipped = false
    let card: Card

    let cardColor = Color(hue: 0.079, saturation: 0.389, brightness: 0.423)
    let textColor = Color(hue: 0.119, saturation: 0.092, brightness: 1.0)

    var body: some View {
        VStack {
            Text(isFlipped ? card.answer : card.question)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(textColor)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .background(cardColor)
                .cornerRadius(20)
                .shadow(radius: 4)
                .onTapGesture {
                    withAnimation {
                        isFlipped.toggle()
                    }
                }
                .padding()
        }
        .padding()
        .onChange(of: card) { _ in
            isFlipped = false
        }
    }
}

#Preview {
    Flashcards(card: Card(question: "What is 2 + 2?", answer: "4"))
}

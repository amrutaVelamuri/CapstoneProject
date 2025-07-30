//
//  Flashcards.swift
//  CapstoneProject
//
//  Created by Amruta Velamuri on 7/29/25.
//

import SwiftUI

struct Flashcards: View {
    @State private var isFlipped = false
    
    let card: Card

    var body: some View {
        VStack {
            Text(isFlipped ? card.answer : card.question)
                .font(.title2)
                .fontWeight(.medium)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(12)
                .onTapGesture {
                    withAnimation {
                        isFlipped.toggle()
                    }
                }
                .padding()
        }
        .padding()
    }
}

#Preview {
    Flashcards(card: Card(question: "What is 2 + 2?", answer: "4"))
}

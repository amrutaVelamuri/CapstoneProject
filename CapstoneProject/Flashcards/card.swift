//
//  card.swift
//  CapstoneProject
//
//  Created by Amruta Velamuri on 7/29/25.
//
import Foundation
import SwiftData
@Model
class Card{
    var question:String
    var answer:String
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}

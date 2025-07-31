//
//  plannerIteam.swift
//  CapstoneProject
//
//  Created by Ámbar Aguilar Sánchez on 30/07/25.
//
import Foundation
import Foundation
import SwiftData

@Model
class plannerItem {
    var task: String
    var date: Date
    var isDone: Bool

    init(task: String, date: Date, isDone: Bool = false) {
        self.task = task
        self.date = date
        self.isDone = isDone
    }
}



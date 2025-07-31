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
class PlannerItem {
    var task: String
    var date: Date
    var time: Date
 amruta-dev
    var isDone: Bool

    var isDone: Bool = false
 main

    init(task: String, date: Date, time: Date, isDone: Bool = false) {
        self.task = task
        self.date = date
        self.time = time
        self.isDone = isDone
    }
}
 amruta-dev



 main

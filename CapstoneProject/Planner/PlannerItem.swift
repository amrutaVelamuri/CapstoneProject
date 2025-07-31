
import Foundation
import SwiftData

@Model
class PlannerItem {
    var task: String
    var date: Date
    var time: Date
    var isDone: Bool

    init(task: String, date: Date, time: Date, isDone: Bool = false) {
        self.task = task
        self.date = date
        self.time = time
        self.isDone = isDone
    }
}

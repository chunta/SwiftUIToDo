import Foundation

enum ToDoStatus: String, Codable {
    case toDo = "ToDo"
    case inProgress = "InProgress"
    case done = "Done"
}

struct ToDoItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var status: ToDoStatus
    var createdAt: Date

    init(title: String, status: ToDoStatus = .toDo) {
        id = UUID()
        self.title = title
        self.status = status
        createdAt = Date()
    }
}

import Combine
import Foundation

protocol ToDoServiceProtocol {
    func fetchToDos() -> AnyPublisher<[ToDoItem], Never>
    func addToDo(_ item: ToDoItem)
    func removeToDo(_ id: UUID)
    func updateToDo(_ item: ToDoItem)
}

final class ToDoService: ToDoServiceProtocol {
    @Published private var toDos: [ToDoItem] = []

    init() {
        // 初始化一些預設的 ToDoItem
        toDos = [
            ToDoItem(title: "Buy groceries", status: .toDo),
            ToDoItem(title: "Call mom", status: .inProgress),
            ToDoItem(title: "Finish SwiftUI project", status: .done),
        ]
    }

    func fetchToDos() -> AnyPublisher<[ToDoItem], Never> {
        $toDos.eraseToAnyPublisher()
    }

    func addToDo(_ item: ToDoItem) {
        toDos.append(item)
    }

    func removeToDo(_ id: UUID) {
        toDos.removeAll { $0.id == id }
    }

    func updateToDo(_ item: ToDoItem) {
        if let index = toDos.firstIndex(where: { $0.id == item.id }) {
            toDos[index] = item
        }
    }
}

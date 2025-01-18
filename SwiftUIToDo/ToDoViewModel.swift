import Combine
import Foundation

protocol ToDoViewModelProtocol: ObservableObject {
    var todos: [ToDoItem] { get }
    func fetchToDos()
    func addToDo(title: String)
    func toggleCompletion(for id: UUID)
    func deleteToDo(at offsets: IndexSet)
}

final class ToDoViewModel: ToDoViewModelProtocol {
    @Published private(set) var todos: [ToDoItem] = []
    private var cancellables = Set<AnyCancellable>()
    private let toDoService: ToDoServiceProtocol

    init(service: ToDoServiceProtocol) {
        toDoService = service
        fetchToDos()
    }

    func fetchToDos() {
        toDoService.fetchToDos()
            .receive(on: DispatchQueue.main)
            .assign(to: &$todos)
    }

    func addToDo(title: String) {
        let newToDo = ToDoItem(title: title)
        toDoService.addToDo(newToDo)
        fetchToDos()
    }

    func toggleCompletion(for id: UUID) {
        guard let index = todos.firstIndex(where: { $0.id == id }) else { return }
        var item = todos[index]

        // 循環切換狀態
        switch item.status {
        case .toDo:
            item.status = .inProgress
        case .inProgress:
            item.status = .done
        case .done:
            item.status = .toDo
        }

        toDoService.updateToDo(item)
        fetchToDos()
    }

    func deleteToDo(at offsets: IndexSet) {
        offsets.map { todos[$0].id }.forEach { id in
            toDoService.removeToDo(id)
        }
        fetchToDos()
    }
}

import SwiftUI

struct ChildView: View {
    @Binding var counter: Int
    
    var body: some View {
        VStack {
            Text("Child Counter: \(counter)")
                .font(.title)
            
            Button("Increase in Child") {
                counter += 1
            }
            .padding()
        }
    }
}

struct ToDoListView<ViewModel: ToDoViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    @State private var tt = CryMe()
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            List {
                ChildView(counter: $tt.count)
                Text("\(tt.count)")
                ForEach(viewModel.todos) { item in
                    HStack {
                        Button(action: {
                            viewModel.toggleCompletion(for: item.id)
                        }) {
                            Image(systemName: icon(for: item.status))
                                .foregroundColor(color(for: item.status))
                        }
                        Text(item.title)
                            .foregroundColor(item.status == .done ? .gray : .black)
                            .strikethrough(item.status == .done, color: .gray)
                    }
                }
                .onDelete(perform: viewModel.deleteToDo)
            }
            .navigationTitle("ToDo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add \(viewModel.todos.count)") {
                        viewModel.addToDo(title: "New Task")
                    }
                }
            }
        }
    }

    // 狀態對應的圖標
    private func icon(for status: ToDoStatus) -> String {
        switch status {
        case .toDo:
            return "circle"
        case .inProgress:
            return "hourglass"
        case .done:
            return "checkmark.circle.fill"
        }
    }

    // 狀態對應的顏色
    private func color(for status: ToDoStatus) -> Color {
        switch status {
        case .toDo:
            return .gray
        case .inProgress:
            return .blue
        case .done:
            return .green
        }
    }
}

#Preview {
    ToDoListView(viewModel: ToDoViewModel(service: ToDoService()))
}

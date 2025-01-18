```
struct ToDoListView<ViewModel: ToDoViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
```
這邊使用泛型,是因為可以讓編譯器在編譯時間檢查我們帶入的具體物件是否符合ToDoViewModelProtocol與是否為ObservableObject \
如果是使用@StateObject private var viewModel: any ToDoViewModelProtocol時,由於protocol本身無法storage property, ex @Published, \
必須runtime才能決定 由於這種不確定性 所以編譯器會報錯

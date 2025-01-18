//
//  SwiftUIToDoApp.swift
//  SwiftUIToDo
//
//  Created by Rex Chen on 2025/1/18.
//

import SwiftUI

@main
struct SwiftUIToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView(viewModel: ToDoViewModel(service: ToDoService()))
        }
    }
}

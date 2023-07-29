//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by antony miller on 7/26/23.
//

import SwiftUI
import SwiftData

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .modelContainer(for: ToDo.self)
        }
    }
}

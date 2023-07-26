//
//  ContentView.swift
//  ToDoList
//
//  Created by antony miller on 7/26/23.
//

import SwiftUI

struct ToDoListView: View {
    var body: some View {
        
        NavigationStack {
            VStack {
                

            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}

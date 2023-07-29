//
//  ContentView.swift
//  ToDoList
//
//  Created by antony miller on 7/26/23.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    
    @State private var sheetIsPresented = false
    
    // @Query gets data from the Data container
    @Query var toDos: [ToDo]
    @Environment(\.modelContext) var modelContext // object peforms crud on DataModels in the .modelContainer in app file
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(toDos){ toDo in
                   
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                toDo.isCompleted.toggle()
                            }
                        NavigationLink {
                            DetailView(toDo: toDo)
                        } label: {
                            Text(toDo.item)
                        }
                    }
                    .font(.title2)
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            modelContext.delete(toDo)
                        }
                    }
                }
    
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .toolbar {
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
            }
        }
        .sheet(isPresented: $sheetIsPresented) {
            NavigationStack {
                DetailView(toDo: ToDo())
            }
        }
        
    }
}

#Preview {
    ToDoListView()
}

//
//  ContentView.swift
//  ToDoList
//
//  Created by antony miller on 7/26/23.
//

import SwiftUI

struct ToDoListView: View {
    
    @State private var sheetIsPresented = false
    @EnvironmentObject var toDosVM: ToDosViewModel
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(toDosVM.toDos){ toDo in
                   
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                toDosVM.toggleCompleted(toDo: toDo)
                            }
                        NavigationLink {
                            DetailView(toDo: toDo)
                        } label: {
                            Text(toDo.item)
                        }
                    .font(.title2)
                    }
                }
                .onDelete { indexSet in
                    toDosVM.deleteToDo(indexSet: indexSet)
                }
                .onMove { fromOffsets, toOffset in
                    toDosVM.moveToDo(fromOffsets: fromOffsets, toOffset: toOffset)
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
            .environmentObject(ToDosViewModel())
    }
}

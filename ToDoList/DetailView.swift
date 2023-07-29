//
//  DetailView.swift
//  ToDoList
//
//  Created by antony miller on 7/26/23.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var toDo: ToDo
    
    var body: some View {
            List {
                TextField("Enter To Do here", text: $toDo.item)
                    .font(.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical)
                    .listRowSeparator(.hidden)
                
                Toggle("Set Reminder:", isOn: $toDo.reminderIsOn)
                    .padding(.top)
                    .listRowSeparator(.hidden)
                
                DatePicker("Date", selection: $toDo.dueDate)
                    .listRowSeparator(.hidden)
                    .padding(.bottom)
                    .disabled(!toDo.reminderIsOn)
                
                Text("Notes")
                    .padding(.top)
                
                TextField("Notes", text: $toDo.notes, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .listRowSeparator(.hidden)
                
                Toggle("Complete:", isOn: $toDo.isCompleted)
                    .padding(.top)
                    .listRowSeparator(.hidden)
                
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel" ){
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save" ){
                        modelContext.insert(toDo)
                        dismiss()
                    }
                }
                
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
        
        
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(toDo: ToDo())
//    }
//}

#Preview {
    NavigationStack {
        DetailView(toDo: ToDo())
            .modelContainer(for: ToDo.self)
    }
}

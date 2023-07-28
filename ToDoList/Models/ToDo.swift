//
//  ToDo.swift
//  ToDoList
//
//  Created by antony miller on 7/26/23.
//

import Foundation

struct ToDo: Identifiable, Codable {
    var id: String? 
    
    var item = ""
    var reminderIsOn = false
    var dueDate = Date.now + (60*60*24)
    var notes = ""
    var isCompleted = false
}

class ToDosViewModel: ObservableObject {
    @Published var toDos: [ToDo] = []
    
    init() {
        loadData()
    }
    
    func toggleCompleted(toDo: ToDo) {
        guard toDo.id != nil else {return}
        
        var newToDo = toDo
        newToDo.isCompleted.toggle()
        
        if let index = toDos.firstIndex(where: {$0.id == newToDo.id}) {
            toDos[index] = newToDo
        }
        saveData()
    }
    
    func saveToDo(toDo: ToDo) {
        if toDo.id == nil {
            var newToDo = toDo
            newToDo.id = UUID().uuidString
           toDos.append(newToDo)
            
        } else {
            if let index = toDos.firstIndex(where: {$0.id == toDo.id}) {
               toDos[index] = toDo
               
            }
        }
        
        saveData()
    }
    
    func deleteToDo(indexSet: IndexSet) {
        toDos.remove(atOffsets: indexSet)
        saveData()
    }
    
    func moveToDo(fromOffsets: IndexSet, toOffset: Int) {
         toDos.move(fromOffsets: fromOffsets, toOffset: toOffset)
        
        saveData()
    }
    
    func loadData() {
        let path = URL.documentsDirectory.appending(component: "toDos")
        
        guard let data = try? Data(contentsOf: path) else {return}
        
        do {
            toDos = try JSONDecoder().decode(Array<ToDo>.self, from: data)
            
        } catch {
            print("Error: Could not load data \(error.localizedDescription)")
        }
    }
    
    func saveData() {
        // store the URL which contains the path to the location on device where files are saved and the name of file to save.
        let path = URL.documentsDirectory.appending(component: "toDos")
        
        // attempt to Encode the data that needs to be saved into JSON
        let data = try? JSONEncoder().encode(toDos)
        
        do {
            try data?.write(to: path)
        } catch {
            print("Error: Could not save data \(error.localizedDescription)")
        }
    }
}

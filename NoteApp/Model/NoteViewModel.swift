//
//  NoteModel.swift
//  Notely
//
//  Created by macbook on 21.10.2022.
//

import Foundation


class NoteViewModel: ObservableObject {
    
    @Published var notes: [NoteModel] = [] {
        didSet {
            saveNotes()
        }
    }
    
    init() {
        getNotes()
    }
    
    
    let notesKey: String = "notes_list"
    
    
    func getNotes() {
        guard
            let data = UserDefaults.standard.data(forKey: notesKey),
            let savedNotes = try? JSONDecoder().decode([NoteModel].self, from: data)
        else { return }
        
        self.notes = savedNotes
    }
    
    func deleteNotes(indexSet: IndexSet) {
        notes.remove(atOffsets: indexSet)
    }
    
    func moveNotes(from: IndexSet, to: Int) {
        notes.move(fromOffsets: from, toOffset: to)
    }
    
    func addNotes(title: String, date: String, description: String) {
        let uuid = NSUUID()
        let newItem = NoteModel(id: uuid as UUID, title: title, date: date, description: description)
        notes.append(newItem)
    }
    
    
    
    func updateNotes(id: UUID, title: String, date: String, description: String) {
        if let note = notes.first(where: { $0.id == id}) {
            let index = notes.firstIndex(of: note)
            notes[index!].title = title
            notes[index!].date = date
            notes[index!].description = description
        }
        
    }
    
    func saveNotes() {
        if let encodedData = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encodedData, forKey: notesKey)
        }
    }
}


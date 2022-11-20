

import Foundation

struct NoteModel: Identifiable, Codable, Equatable {
    
    var id = UUID()
    var title: String
    var date: String
    var description: String
    
    init(id: UUID, title: String, date: String, description: String) {
        self.id = id
        self.title = title
        self.date = date
        self.description = description
    }
    
    func updateCompletion() -> NoteModel {
        return NoteModel(id: id, title: title, date: date, description: description)
    }
    
    
}

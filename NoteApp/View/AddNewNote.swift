//
//  AddNewNote.swift
//  Notely
//
//  Created by macbook on 11.09.2022.
//

import SwiftUI


struct AddNewNote: View {
    
    @AppStorage("isDark") private var isDark = false
    @State var newTitle: String = ""
    @State var newDescription: String = ""
    @EnvironmentObject var noteViewModel: NoteViewModel
    @Environment(\.presentationMode) var presentedMode
    @FocusState private var fieldInFocus: Bool
    
    
    var body: some View {

                twoTextFields

            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 15)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: leadingButton,
                                trailing: doneNote)
            .navigationBarBackButtonHidden(true)
            .background(Color("backgroundColor"))
            .preferredColorScheme(isDark ? .dark : .light)
        }
    
    
    
    
    func saveButtonPressed() {
        noteViewModel.addNotes(title: newTitle, date: takeDate(), description: newDescription)
        presentedMode.wrappedValue.dismiss()
    }
    
    func takeDate() -> String {
        var time = NSDate()
        var formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        var formatteddate = formatter.string(from: time as Date)
        let date = "\(formatteddate)"
            return date
    }
    
    
}



struct AddNewNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNewNote()
            .previewDevice("iphone 11")
            .environmentObject(NoteViewModel())
    }
}


extension AddNewNote {
    
    //MARK: leadingButton
    private var leadingButton: some View {
        HStack {
            Button(action: {
                presentedMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.primaryRed)
            }
            .padding(.trailing, 20)
            Text(takeDate())
        }
    }
    
    private var doneNote: some View {
        Button(action: {
            saveButtonPressed()
        }) {
            Image(systemName: "checkmark")
                .foregroundColor(.primaryRed)
        }
    }
    
    private var twoTextFields: some View {
        VStack (alignment: .leading, spacing: 8){
            TextField("Название заметки...", text: $newTitle)
                .focused($fieldInFocus)
                .frame(height: 30)
                .multilineTextAlignment(.leading)
                .foregroundColor(.primaryRed)
                .lineLimit(1)
                .font(.headline)
                .padding(.top, 15)
                .padding(.horizontal)
            if #available(iOS 16.0, *) {
                TextEditor(text: $newDescription)
                    .multilineTextAlignment(.leading)
                    .textSelection(.enabled)
                    .scrollContentBackground(.hidden) // <- Hide it
                    .foregroundColor(Color("textColor"))
                    .padding()
                    .background(Color("backgroundColor"))
            } else {
                TextEditor(text: $newDescription)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("textColor"))
                    .padding()
                    .background(Color("backgroundColor"))
            }
            
            Spacer()
        }
        
    }

}

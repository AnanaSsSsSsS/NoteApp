//
//  AddNewNote.swift
//  Notely
//
//  Created by macbook on 11.09.2022.
//

import SwiftUI


struct AddNewNote: View {
    
    @State var newTitle: String = ""
    @State var newDescription: String = ""
    @EnvironmentObject var noteViewModel: NoteViewModel
    @Environment(\.presentationMode) var presentedMode
    
    
    var leadingButton: some View {
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
    
    var doneNote: some View {
        Button(action: {
            saveButtonPressed()
        }) {
            Image(systemName: "checkmark")
                .foregroundColor(.primaryRed)
        }
    }
    
    
    var body: some View {
            VStack (alignment: .leading, spacing: 8){
                
                TextField("", text: $newTitle)
                    .frame(height: 30)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primaryRed)
                    .lineLimit(1)
                    .font(.headline)
                    .padding(.top, 15)
                    .padding(.horizontal)
                TextEditor(text: $newDescription)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .padding()
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 15)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: leadingButton,
                                trailing: doneNote)
            .navigationBarBackButtonHidden(true)
        }
    
    
    
    
    func saveButtonPressed() {
        noteViewModel.addNotes(title: newTitle, date: takeDate(), description: newDescription)
        presentedMode.wrappedValue.dismiss()
    }
    
    func takeDate() -> String {
        var time = NSDate()
        var formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
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

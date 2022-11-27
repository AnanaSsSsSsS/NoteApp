
import SwiftUI

struct NoteDetailView: View {
    
    @State var note: NoteModel    // для использования массива с данными и возможности вставлять сразу в text editor без использования .onApear{newTitle = note.title}
    
    @Environment(\.presentationMode) var presentedMode
    
    @EnvironmentObject var noteViewModel: NoteViewModel

    @State var newTitle: String = ""
    @State var newDate: String = ""
    @State var newDescription: String = ""
    let caracterLimit = 25
    
    var body: some View {
                
        mainBody
        
        .background(Color("backgroundForTitle"))
        .navigationBarItems(leading: leadingButton,
                            trailing: trailingButton)
        .navigationBarBackButtonHidden(true)
    }
    
    
    func updateMyNewNote() {
        noteViewModel.updateNotes(id: note.id, title: note.title, date: takeDate(), description: note.description)
    
        noteViewModel.saveNotes()
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

struct NoteDetailViewPreview: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            NoteDetailView(note: NoteModel(id: UUID(), title: "FHDJHJGF", date: "13.10.1957", description: "NFJDSFI FSFH SFDSJKN NFKVJDSN JFNS"))
        }
    }

    
}

extension NoteDetailView {
    
    // MARK: mainBody
    private var mainBody: some View {
        VStack(alignment: .leading, spacing: 4) {
            if #available(iOS 15.0, *) {
                TextField("", text: $note.title)
                    .disabled(newTitle.count > caracterLimit)
                    .multilineTextAlignment(.leading)
                    .textSelection(.enabled)
                    .foregroundColor(.primaryRed)
                    .lineLimit(1)
                    .font(.headline)
                    .padding(.top, 15)
                    .padding(.horizontal)
            } else {
                TextField("", text: $note.title)
                    .disabled(newTitle.count > caracterLimit)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primaryRed)
                    .lineLimit(1)
                    .font(.headline)
                    .padding(.top, 15)
                    .padding(.horizontal)
            }
            
            if #available(iOS 15.0, *) {
                TextEditor(text: $note.description)
                    .multilineTextAlignment(.leading)
                    .textSelection(.enabled)
                    .foregroundColor(Color.black)
                    .padding()
            } else {
                TextEditor(text: $note.description)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.black)
                    .padding()
            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 15)
    }
    
    // MARK: leadingButton
    private var leadingButton: some View {
        HStack {
            Button(action: {
                presentedMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.primaryRed)
            }
            Spacer()
            VStack {
                Text(note.date)
                    .foregroundColor(.black)
                Divider()
                    .frame(height: 2)
                    .overlay(.black)
            }

        }
    }
    
    // MARK: trailingButton
    private var trailingButton: some View {
        Button(action: {
            updateMyNewNote()
            presentedMode.wrappedValue.dismiss()}){
                Image(systemName: "checkmark")
            }
            .foregroundColor(.primaryRed)
    }
    
    
}


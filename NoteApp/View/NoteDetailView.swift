
import SwiftUI

struct NoteDetailView: View {
    
    @State var note: NoteModel    // для использования массива с данными и возможности вставлять сразу в text editor без использования .onApear{newTitle = note.title}
    
    @Environment(\.presentationMode) var presentedMode
    //: Binding<PresentationMode>
    
    @EnvironmentObject var noteViewModel: NoteViewModel

    
    @State var newTitle: String = ""
    @State var newDate: String = ""
    @State var newDescription: String = ""
    
    var leadingButton: some View {
        HStack {
            Button(action: {
                presentedMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.primaryRed)
            }
            Spacer()
            Text(note.date)
                .foregroundColor(.black)

        }
    }
    
    var body: some View {
                
        mainBody
        
        .background(Color("backgroundForTitle"))
        .navigationBarItems(leading: leadingButton,
                            trailing: Button(action: {
                        updateMyNewNote()
            presentedMode.wrappedValue.dismiss()
        }){ Image(systemName: "checkmark")
        }
                .foregroundColor(.primaryRed))
        .navigationBarBackButtonHidden(true)
    }
    
    func updateMyNewNote() {
        
        noteViewModel.updateNotes(id: note.id, title: note.title, date: note.date, description: note.description)
        
        noteViewModel.saveNotes()
    }
    
}

struct NoteDetailViewPreview: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            NoteDetailView(note: NoteModel(id: UUID(), title: "FHDJHJGF", date: "13/10/1957", description: "NFJDSFI FSFH SFDSJKN NFKVJDSN JFNS"))
        }
    }

    
}

extension NoteDetailView {
    private var mainBody: some View {
        VStack(alignment: .leading, spacing: 4) {
            if #available(iOS 15.0, *) {
                TextEditor(text: $note.title)
                    .multilineTextAlignment(.leading)
                    .textSelection(.enabled)
                    .foregroundColor(.primaryRed)
                    .lineLimit(1)
                    .font(.headline)
                    .padding(.top, 15)
                    .padding(.horizontal)
            } else {
                TextEditor(text: $note.title)
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
}


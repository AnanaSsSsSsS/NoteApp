
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
        Button(action: {
            presentedMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.primaryRed)
        }
    }
    
    var body: some View {
//        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    TextEditor(text: $note.title)
//                        .textSelection(.enabled)
                        .frame(width: .infinity, height: 30)
                        .foregroundColor(.primaryRed)
                        .lineLimit(1)
                        .font(.headline)
                        .padding(.top, 15)
                        .padding(.horizontal)
                    TextEditor(text: $note.date)
                        .frame(width: .infinity, height: 30)
                        .font(.primary(.medium, size: 13))
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    TextEditor(text: $note.description)
                        .frame(width: .infinity, height: 30)
                        .foregroundColor(Color.black)
                        .padding()
                    HStack{
                        Spacer()
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading )
                .padding()
            }
            
//        }
//        .edgesIgnoringSafeArea(.bottom)
        .background(Color("backgroundForTitle"))
//        .navigationBarTitleDisplayMode(.inline)
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
        
        noteViewModel.updateNotes(id: note.id, title: note.title, date: note.date, description: note.description)  //почему не работает
        
        noteViewModel.saveNotes()
    }
    
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 0.0
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: .init(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct NoteDetailViewPreview: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            NoteDetailView(note: NoteModel(id: UUID(), title: "FHDJHJGF", date: "13/10/1957", description: "NFJDSFI FSFH SFDSJKN NFKVJDSN JFNS"))
        }
    }

    
}


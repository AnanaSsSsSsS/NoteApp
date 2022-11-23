

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var noteViewModel: NoteViewModel
    

    private var _leadingTitle: some View {
        
        Text("My Notes")
            .font(.primary(.bold, size: 23))
            .foregroundColor(.primary)
    }
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(Color("backgroundForTitle"))
        UINavigationBar.appearance().tintColor = UIColor(Color.white)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    
    
    
    var body: some View {
 
        NavigationView {
            VStack {
                ZStack(alignment: .bottomTrailing) {

                    List {
                        ForEach(noteViewModel.notes) { eachNote in
                            
                            if #available(iOS 15.0, *) {
                                NavigationLink(destination: NoteDetailView(note: eachNote)
                                               , label: {
                                    NoteViewItem(note: eachNote)
                                }
                                )
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                    Button("tap") {}
                                }
                            } else {
                                NavigationLink(destination: NoteDetailView(note: eachNote)
                                               , label: {
                                    NoteViewItem(note: eachNote)
                                }
                                )
                            }
                            
                        }
                        .onDelete(perform: noteViewModel.deleteNotes)
                        .onMove(perform: noteViewModel.moveNotes)
                    }
                    .listStyle(PlainListStyle())
                    

                    
                    NavigationLink(destination: AddNewNote.init()) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Create")
                                .font(.primary(.semiBold, size: 16))
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 130, height: 52)
                        .background(Color.primaryRed)
                        .cornerRadius(30.5)
                        .padding(.trailing)
                        .shadow(color: Color.black.opacity(0.3), radius: 10)
                    }
                }
            }
            .background(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: _leadingTitle, trailing: NavigationLink(destination: SettingsView(), label: {
                Image(systemName: "list.bullet.indent")
                    .foregroundColor(.primaryRed)
                
                })
            )
        }
    }
    
}

struct NoteViewItem : View {
    
    let note: NoteModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: nil, content: {
                VStack(alignment: .leading, spacing: 4) {
                    Text(note.date)
                        .foregroundColor(.primary)
                        .font(.primary(.semiBold, size: 9))
                        .padding(.leading, 12)
                    Text(note.title)
                        .lineLimit(1)
                        .foregroundColor(.primaryRed)
                        .font(.primary(.bold, size: 17))
                        .padding(.leading, 9)
            }
            .padding(4)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .background(Color.lightGrey)
                .padding(.trailing)
                .padding(.leading)

            Text(note.description)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .font(.primary(.regular, size: 13))
                .foregroundColor(.primary)
                .lineSpacing(7.0)
                .padding(.leading, 13)
                .padding(.top, 8)
                .padding(.bottom, 8)

        })
        .cornerRadius(8)
    }
    
}


struct HomeViewPreview: PreviewProvider {
    
    static var previews: some View {
        HomeView()
            .previewDevice("iphone 11")
            .environmentObject(NoteViewModel())
            .preferredColorScheme(.dark)
    }
}



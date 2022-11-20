//
//  NotelyApp.swift
//  Notely
//
//  Created by Marasy Phi on 9/1/21.
//

import SwiftUI

@main
struct NoteAppApp: App {
    
    @StateObject var noteViewModel: NoteViewModel = NoteViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{  // теперь все вью в проекте будут
                ContentView()  // старотовое View
            }
            .environmentObject(noteViewModel)
        }
    }
}

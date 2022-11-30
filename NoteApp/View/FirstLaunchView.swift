//
//  FirstLaunchView.swift
//  NoteApp
//
//  Created by macbook on 30.11.2022.
//

import SwiftUI

struct FirstLaunchView: View {
    
    @State var isPresented: Bool = false
    @AppStorage("firstLaunch") var isFirstLaunch: Bool = true
    
    var body: some View {
        
        VStack {
            Spacer().frame(height: 52)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Notely")
                    .font(.primary(.black, size: 35))
                    .foregroundColor(.darkerText)
                    .padding(15)
                Text("Capture what’s on your mind & get a reminder later at the right place or time. You can also add voice memo & other features")
                    .font(.primary(.regular, size: 16))
                    .foregroundColor(.lightText)
                    .lineSpacing(10.0)
                    .padding(15)
            }
            
            Spacer()
            
            ZStack(alignment: .bottomTrailing) {
                Image("splash")
                    .resizable()
                    .edgesIgnoringSafeArea(.bottom)
                Button(action: {
                    isPresented.toggle()
                    isFirstLaunch = false
                }, label: {
                    HStack {
                        Text("Let's Start")
                            .font(.primary(.semiBold, size: 16))
                        Image(systemName: "arrow.right")
                    }
                    .fullScreenCover(isPresented: $isPresented, content: {
                        HomeView()
                    })
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 164, height: 52)
                    .background(Color.primaryRed)
                    .cornerRadius(30.5)
                    .padding(.trailing)
                }).padding()
                    .shadow(color: Color.black.opacity(0.3), radius: 10)
            }
        }
        
        
        
        
        
    }
}

struct FirstLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLaunchView()
    }
}

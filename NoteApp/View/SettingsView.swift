

import SwiftUI

struct SettingsView: View {

@AppStorage("isDark") private var isDark = false
@State private var DemandPassword = false
@State private var SizeOfFont = 10
@Environment(\.presentationMode) var presentedMode
    

    var body: some View {
            VStack {
                    Form {
                        
                        fullSection
                        
                        aboutMe
                        
                    }
                .preferredColorScheme(isDark ? .dark : .light)
                .background(Color("backgroundColor"))
                .environment(\.colorScheme, isDark ? .dark : .light)
                .navigationBarItems(leading: leadingButton)
                .navigationBarBackButtonHidden(true)
        }
    }
}



struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .previewDevice("iPhone 11")
    }
}


extension SettingsView {
    
    // MARK: leadingButton
    private var leadingButton: some View {
        Button(action: {
            presentedMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.primaryRed)
        }
    }
    
    // MARK: fullSection
    private var fullSection: some View {
        Section(header: Text("Settings")
            .foregroundColor(.gray)
            .fontWeight(.semibold)){
                Toggle("Night Mode", isOn: $isDark)
                .foregroundColor(.red)
            Toggle("Password", isOn: $DemandPassword)
                .foregroundColor(.green)
                Stepper("Font Size", value: $SizeOfFont, in: 5...20){_ in
                    UserDefaults.standard.set(SizeOfFont, forKey: "CurrentFontSize")
                    UserDefaults.standard.synchronize()
                }
                .foregroundColor(.purple)
            Text("Current text size is \(SizeOfFont)")
                .fontWeight(.semibold)
                .foregroundColor(.darkText)

        }
    }
    
    // MARK: aboutMe
    private var aboutMe: some View {
        HStack {
            Spacer()
            Button(action: {}){
                Image(systemName: "bubble.right.fill")
                    .foregroundColor(.black)

            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "captions.bubble.fill")
                    .foregroundColor(.black)

            }
            Spacer()
            Button(action: {}){
                Image(systemName: "gamecontroller.fill")
                    .foregroundColor(.black)
                
            }
            Spacer()
        }
    }
    
}

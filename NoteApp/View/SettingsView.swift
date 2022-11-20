

import SwiftUI

struct SettingsView: View {

@State private var StartNightMode = false
@State private var DemandPassword = false
@State private var SizeOfFont = 10
@Environment(\.presentationMode) var presentedMode
    
    var leadingButton: some View {
        Button(action: {
            presentedMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.primaryRed)
        }
    }
    

var body: some View {
    
        VStack{
            Form {
                Section(header: Text("Settings")
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)){
                    Toggle("Night Mode", isOn: $StartNightMode)
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

//        .navigationBarHidden(true)
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

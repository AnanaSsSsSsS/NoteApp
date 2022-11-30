

import SwiftUI

struct ContentView: View {
    
    @AppStorage("firstLaunch") var isFirstLaunch: Bool = true
    
    var body: some View {
        ZStack {
            if isFirstLaunch {
                FirstLaunchView()
            } else {
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



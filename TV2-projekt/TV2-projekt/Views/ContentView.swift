//
//  ContentView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 12/03/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userVM: UserVM
    var body: some View {
        Group {
            if userVM.isUserAuthenticated == .undefined {
                Text("Loading...")
            } else if userVM.isUserAuthenticated == .signedOut {
                SignInView()
            } else {
                HomeView() 
            }
        }
        .onAppear {
            self.userVM.configureFirebaseStateDidChange()
        } 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

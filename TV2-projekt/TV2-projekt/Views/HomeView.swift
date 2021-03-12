//
//  HomeView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 12/03/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        NavigationView {
            Text("Logged in as user")
                .navigationBarTitle("Forside")
                .navigationBarItems(trailing: Button("Log out") {
                    self.userInfo.isUserAuthenticated = .signedOut
                })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

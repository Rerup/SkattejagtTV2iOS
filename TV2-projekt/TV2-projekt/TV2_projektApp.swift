//
//  TV2_projektApp.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 02/03/2021.
//

import SwiftUI
import Firebase

@main
struct TV2_projektApp: App {
    var userInfo = UserInfo()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userInfo)
        }
    }
}

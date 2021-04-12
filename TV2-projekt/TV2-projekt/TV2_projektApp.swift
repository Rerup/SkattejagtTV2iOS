//
//  TV2_projektApp.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 02/03/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

let db = Firestore.firestore()
let userRepository = UserRepository()

@main
struct TV2_projektApp: App {
    var taskViewModel = TaskVM()
    var userVM = UserVM()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userVM).environmentObject(taskViewModel)
        }
    }
}

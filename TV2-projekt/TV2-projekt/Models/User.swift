//
//  User.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 04/03/2021.
//

import SwiftUI

class User {
    let id: String
    var email: String?
    var displayName: String?
    var firstname: String
    var lastname: String
    var point: Int = 0
    var doneTasks: [String] = []
    
    init(id: String, email: String?, displayName:String?, firstname:String, lastname: String) {
        self.id = id
        self.email = email
        self.displayName = displayName
        self.firstname = firstname
        self.lastname = lastname
    }
}

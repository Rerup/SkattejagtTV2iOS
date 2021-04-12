//
//  User.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 06/04/2021.
//

import SwiftUI

struct User: Encodable, Decodable {
    let uid: String
    let name: String
    let email: String
    let cid: String
    let totalPoints: Int
    let completedTasks: [String]
    
    init(uid: String, name:String, email: String, cid:String, totalPoints:Int, completedTasks: [String] ) {
        self.uid = uid
        self.name = name
        self.email = email
        self.cid = cid
        self.totalPoints = totalPoints
        self.completedTasks = completedTasks
    }
}

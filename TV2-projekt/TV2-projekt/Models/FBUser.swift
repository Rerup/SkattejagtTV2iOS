//
//  FBUser.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 12/03/2021.
//

import Foundation

struct FBUser {
    let uid: String
    let name: String
    let email: String
    let cid: String
    let totalPoints: Int
    let completedTasks: [String]
    
    init(uid: String, name: String, email: String, cid:String, totalPoints: Int, completedTasks: [String]) {
        self.uid = uid
        self.name = name
        self.email = email
        self.cid = cid
        self.totalPoints = totalPoints
        self.completedTasks = completedTasks
    }
}

extension FBUser {
    init?(documentData: [String : Any]) {
        let uid = documentData[FBKeys.User.uid] as? String ?? ""
        let name = documentData[FBKeys.User.name] as? String ?? ""
        let email = documentData[FBKeys.User.email] as? String ?? ""
        let cid = documentData[FBKeys.User.cid] as? String ?? ""
        let totalPoints = documentData[FBKeys.User.totalPoints] as? Int ?? 0
        let completedTasks = documentData[FBKeys.User.completedTasks] as? [String] ?? []

        
        self.init(uid: uid,
                  name: name,
                  email: email,
                  cid: cid,
                  totalPoints: totalPoints,
                  completedTasks: completedTasks
        )
    }
    
    static func dataDict(uid: String, name: String, email: String, cid: String, totalPoints: Int, completedTasks: [String]) -> [String: Any] {
        var data: [String: Any]
        
        // If name is not "" this must be a new entry so add all first time data
        if name != "" {
            data = [
                FBKeys.User.uid: uid,
                FBKeys.User.name: name,
                FBKeys.User.email: email,
                FBKeys.User.cid: cid,
                FBKeys.User.totalPoints: totalPoints,
                FBKeys.User.completedTasks: completedTasks
            ]
        } else {
            data = [
                FBKeys.User.uid: uid,
                FBKeys.User.email: email
            ]
        }
        return data
    }
}

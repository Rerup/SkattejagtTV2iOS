//
//  UserRepository.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 16/03/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

let userRef = db.collection("users")

class UserRepository {
    
    func updateCompletedTasks (taskId: String, uid: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        db.collection("users").document(uid).updateData([
            "completedTasks": FieldValue.arrayUnion([taskId])
        ])
        { err in
            if let err = err {
                completionHandler(.failure(err))
            } else {
                completionHandler(.success(true))
            }
        }
    }
    
    func FetchUser(uid: String, completionHandler: @escaping (Result<User, Error>) -> Void) {
        db.collection("users").document(uid).addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("Error fetching user")
                completionHandler(.failure(FireStoreError.noSnapshotData))
                return
            }
            guard let data = document.data() else {
                print("Document was empty")
                completionHandler(.failure(FireStoreError.noUser))
                return
            }
            let uid = data["uid"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let cid = data["cid"] as? String ?? ""
            let totalPoints = data["totalPoints"] as? Int ?? 0
            let completedTasks = data["completedTasks"] as? [String] ?? []
            completionHandler(.success(User(uid: uid, name: name, email: email, cid: cid, totalPoints: totalPoints, completedTasks: completedTasks)))
        }
    }
    
    func CreateUser (withEmail email:String,
                     name: String,
                     password:String,
                     cid: String,
                     totalPoints:Int,
                     completedTasks: [String],
                     completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard let _ = authResult?.user else {
                completionHandler(.failure(error!))
                return
            }
            
            db.collection("users").document(authResult!.user.uid).setData([
                "uid": authResult!.user.uid,
                "name": name,
                "email": email,
                "cid": cid,
                "totalPoints": totalPoints,
                "completedTasks": completedTasks
            ]) { (err) in
                if let err = err {
                    completionHandler(.failure(err))
                    return
                }
                completionHandler(.success(true))
            }
        }
    }
}

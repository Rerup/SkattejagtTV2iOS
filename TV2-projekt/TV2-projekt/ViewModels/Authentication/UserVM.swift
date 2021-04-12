//
//  UserVM.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 06/04/2021.
//

import Foundation
import FirebaseAuth

class UserVM: ObservableObject {
    enum AuthState {
        case undefined, signedOut, signedIn
    }
    
    @Published var isUserAuthenticated: AuthState = .undefined
    @Published var user = User(uid: "", name: "", email: "", cid: "", totalPoints: 0, completedTasks: [])
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    func configureFirebaseStateDidChange() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            guard let user = user else {
                self.isUserAuthenticated = .signedOut
                return
            }
            self.isUserAuthenticated = .signedIn
            userRepository.FetchUser(uid: user.uid) { (result) in
                switch result {
                case .failure(let error):
                print(error)
                case .success(let user):
                self.user = user
                }
            }
        })
    }
    
    func authenticate(withEmail email :String,
                             password:String,
                             completionHandler:@escaping (Result<Bool, EmailAuthError>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            // check the NSError code and convert the error to an AuthError type
            var newError:NSError
            if let err = error {
                newError = err as NSError
                var authError:EmailAuthError?
                switch newError.code {
                case 17009:
                    authError = .incorrectPassword
                case 17008:
                    authError = .invalidEmail
                case 17011:
                    authError = .accoundDoesNotExist
                default:
                    authError = .unknownError
                }
                completionHandler(.failure(authError!))
            } else {
                completionHandler(.success(true))
            }
        }
    }
    
    func createUser(withEmail email:String,
                    name: String,
                    password:String,
                    cid: String,
                    totalPoints:Int,
                    completedTasks: [String],
                    completionHandler:@escaping (Result<Bool,Error>) -> Void) {
        
        userRepository.CreateUser(withEmail: email, name: name, password: password, cid: cid, totalPoints: totalPoints, completedTasks: completedTasks) { (result) in
            switch result {
            case .success(let bool):
                completionHandler(.success(bool))
            return 
            case .failure(let bool):
                completionHandler(.failure(bool))
            return 
            }
        }
    }
    
    func logout(completionHandler: @escaping (Result<Bool, Error>) -> ()) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            completionHandler(.success(true))
        } catch let err {
            completionHandler(.failure(err))
        }
    }
    
    func updateCompletedTasks(taskId: String, completionHandler: @escaping (Result<Bool, Error>)-> ()) {
        userRepository.updateCompletedTasks(taskId: taskId, uid: user.uid) { (result) in
            switch result {
            case .success(let bool):
                completionHandler(.success(bool))
                return
            case .failure(let bool):
                completionHandler(.failure(bool))
                return
            }
        }
    }
}

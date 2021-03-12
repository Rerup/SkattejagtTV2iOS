//
//  UserInfo.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 12/03/2021.
//

import Foundation

class UserInfo: ObservableObject {
    enum FBAuthState {
        case undefined, signedOut, signedIn
    }
    @Published var isUserAuthenticated: FBAuthState = .undefined
    
    func configureFirebaseStateDidChange() {
        self.isUserAuthenticated = .signedOut
    }
}

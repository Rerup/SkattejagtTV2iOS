//
//  LoginView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 04/03/2021.
//

import SwiftUI

struct LoginView: View {
    enum Action {
        case signUp, resetPW
    }
    @State private var showSheet = false
    @State private var action: Action?
    var body: some View {
        SignInWithEmailView(showSheet: $showSheet, action: $action)
            .sheet(isPresented: $showSheet) {
                if self.action == .signUp {
                    SignUpView()
                } else {
                    ForgotPasswordView()
                }
            }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

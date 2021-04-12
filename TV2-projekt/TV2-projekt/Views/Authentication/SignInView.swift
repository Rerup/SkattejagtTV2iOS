//
//  SignInView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 11/04/2021.
//

import SwiftUI

struct SignInView: View {
    enum Action {
        case undefined, signUp, resetPW
    }
    @EnvironmentObject var userVM: UserVM
    @State private var user = UserViewModel()
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var authError: EmailAuthError?
    @State private var action: Action = Action.undefined
    
    var body: some View {
        
        VStack {
            VStack {
                Image("Logo_white")
                    .resizable()
                    .frame(width: 170, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            .padding(.top, 150)
            
            VStack (alignment: .leading) {
                Text("Brugernavn")
                    .bold()
                TextField("Brugernavn...", text: self.$user.email)
                    .background(Color.white)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.top, 65)
            
            VStack (alignment: .leading) {
                Text("Adgangskode")
                    .bold()
                TextField("Adgangskode...", text: self.$user.password)
                    .background(Color.white)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.top, 20)
            
            VStack {
                Button(action: {
                    userVM.authenticate(withEmail: self.user.email, password: self.user.password) { (result) in
                        switch result {
                        case .failure(let error):
                            self.authError = error
                            self.showAlert = true
                        case .success( _):
                            print("Signed in")
                        }
                    }
                }) {
                    Text("Login")
                }
                .frame(width: 150, height: 50)
                .background(Color("thirdColor"))
                .cornerRadius(16)
            }
            .padding(.top, 65)
            .alert(isPresented: $showAlert) {
                Alert(title:  Text("Login Error"), message: Text(self.authError?.localizedDescription ?? "Unknown"), dismissButton: .default(Text("OK")) {
                    if self.authError == .incorrectPassword {
                        self.user.password = ""
                    } else {
                        self.user.email = ""
                        self.user.password = ""
                    }
                })
            }
            
            Spacer()
            
            VStack {
                Button(action: {}) {
                    Text("Opret bruger")
                        .bold()
                }
                
            }
            
            VStack {
                Button(action: {}) {
                    Text("Glemt adgangskode?")
                        .bold()
                }
            }
            .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
        .padding(32)
        .foregroundColor(.white)
        .background(Color("primaryColor")).edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showSheet) {
            if self.action == .signUp {
                SignUpView()
            } else if self.action == .resetPW {
                ForgotPasswordView()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

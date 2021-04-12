//
//  TV2-projekt
//
//  Created by Anders Biller Due on 12/03/2021.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var userVM: UserVM
    @State var user: UserViewModel = UserViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showError = false
    @State private var errorString = ""
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    VStack(alignment: .leading) {
                        TextField("Full Name", text: self.$user.fullname).autocapitalization(.words)
                        if !user.validNameText.isEmpty {
                            Text(user.validNameText).font(.caption).foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading) {
                        TextField("Email Address", text: self.$user.email).autocapitalization(.none).keyboardType(.emailAddress)
                        if !user.validEmailAddressText.isEmpty {
                            Text(user.validEmailAddressText).font(.caption).foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading) {
                        TextField("Enter TV2 id", text: self.$user.cid)
                    }
                    VStack(alignment: .leading) {
                        SecureField("Password", text: self.$user.password)
                        if !user.validPasswordText.isEmpty {
                            Text(user.validPasswordText).font(.caption).foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading) {
                        SecureField("Confirm Password", text: self.$user.confirmPassword)
                        if !user.passwordsMatch(_confirmPW: user.confirmPassword) {
                            Text(user.validConfirmPasswordText).font(.caption).foregroundColor(.red)
                        }
                    }
                }.frame(width: 300)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                VStack(spacing: 20 ) {
                    Button(action: {
                        userVM.createUser(withEmail: self.user.email, name: self.user.fullname, password: self.user.password, cid: self.user.cid, totalPoints: 0, completedTasks: self.user.completedTasks) { (result) in
                            switch result {
                            case .failure(let error):
                                self.errorString = error.localizedDescription
                                self.showError = true
                            case.success( _):
                                print("Account creation succesful")
                            }
                        }
                        
                    }) {
                        Text("Register")
                            .frame(width: 200)
                            .padding(.vertical, 15)
                            .background(Color.green)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .opacity(user.isSignInComplete ? 1 : 0.75)
                    }
                    .disabled(!user.isSignInComplete)
                    Spacer()
                }.padding()
            }.padding(.top)
            .alert(isPresented: $showError) {
                Alert(title: Text("Error creating account"), message: Text(self.errorString), dismissButton: .default(Text("OK")))
            }
                .navigationBarTitle("Sign Up", displayMode: .inline)
                .navigationBarItems(trailing: Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

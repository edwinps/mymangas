//
//  AccountView.swift
//  myMangas
//
//  Created by epena on 13/1/24.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var viewModel: AccountViewModel
    @State var email = ""
    @State var password = ""
    @State var isRegistering: Bool = false
    
    var body: some View {
        VStack {
            if viewModel.loginSuccess {
                Text("Welcome")
                    .font(.title)
                    .foregroundColor(.primary)
                    .bold()
                    .padding()
                Button("Log out") {
                    Task {
                        await viewModel.logout()
                    }
                }
            }
            else {
                Group {
                    if isRegistering {
                        VStack {
                            formFields
                            Button("Register") {
                                Task {
                                    await viewModel.register(email: email, password: password)
                                }
                            }
                        }
                        .loading(loading: viewModel.loading)
                    } else {
                        VStack {
                            formFields
                            Button("Login") {
                                Task {
                                    await viewModel.login(email: email, password: password)
                                }
                            }
                        }
                        .loading(loading: viewModel.loading)
                    }
                }.padding([.leading,.trailing])
                
                if let error = viewModel.registrationError ?? viewModel.loginError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
                if !viewModel.loading {
                    HStack {
                        Button(action: {
                            isRegistering.toggle()
                            viewModel.cleanError()
                        }) {
                            Text(isRegistering ?
                                 "Already have an account? Login"
                                 : "Don't have an account? Register")
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

private extension AccountView {
    var formFields: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
    }
}

private extension View {
    func loading(loading: Bool) -> some View {
        if loading {
            return AnyView(ProgressView("Please wait")
                .scaleEffect(1.5)
                .opacity(0.7))
        } else {
            return AnyView(self)
        }
    }
}

#Preview {
    AccountView(viewModel: .test)
}

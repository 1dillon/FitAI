//
//  ContentView.swift
//  FitAI
//
//  Created by Dillon Shi on 3/2/24.
//

import AuthenticationServices
import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.colorScheme) var colorScheme
    
    // TODO: Create environment object to hold this data
    @AppStorage("userId") var userId: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                if userId.isEmpty {
                    SignInWithAppleButton(.signIn) { request in
                        
                        request.requestedScopes = [.email, .fullName]
                        
                    } onCompletion: { result in
                        
                        switch result {
                        case .success(let auth):
                            
                            switch auth.credential {
                            case let credential as ASAuthorizationAppleIDCredential:
                                
                                // User Id
                                let userId = credential.user
                                
                                // User Info
                                let email = credential.email
                                let firstName = credential.fullName?.givenName
                                let lastName = credential.fullName?.familyName
                                
                                self.userId = userId
                                self.email = email ?? ""
                                self.firstName = firstName ?? ""
                                self.lastName = lastName ?? ""
                                
                            default:
                                break
                            }
                            
                        case .failure(let error):
                            print(error)
                        }
                        
                    }
                    .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                    .frame(height: 50)
                    .padding()
                    .cornerRadius(8)
                }
                
                else {
                    // Signed In
                }
                
            }
            .navigationTitle("Sign In")
        }
    }
}

#Preview {
    ContentView()
}

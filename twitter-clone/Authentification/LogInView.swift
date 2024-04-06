//
//  LogInView.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 02.04.2024.
//

import SwiftUI

struct LogInView: View {
    @State var email = ""
    @State var password = ""
    @State var emailDone = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        if !emailDone {
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Cancel")
                                    .foregroundColor(.blue)
                            })
                            Spacer()
                        }
                        .padding(.horizontal)
                        Image("Twitter")
                            .resizable()
                            .scaledToFill()
                            .padding(.trailing)
                            .frame(width: 20, height: 20)
                    }
                    
                    Text("To get started, first log in.")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    CustomAuthText(placeholder: "Phone, email or username", text: $email)
                }
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                VStack {
                    Button(action: {
                        if !email.isEmpty {
                            self.emailDone.toggle()
                        }
                    }, label: {
                        Capsule()
                            .frame(width: 360, height: 40, alignment: .center)
                            .foregroundColor(Color(red: 29/255, green: 161/255, blue: 242/255))
                            .overlay(Text("Next")
                                .foregroundColor(.white))
                    })
                    .padding(.bottom, 4)
                    
                    Text("Forget password?")
                        .foregroundColor(.blue)
                        .padding(.bottom)
                }
            }
        }
        else {
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Cancel")
                                    .foregroundColor(.blue)
                            })
                            Spacer()
                        }
                        .padding(.horizontal)
                        Image("Twitter")
                            .resizable()
                            .scaledToFill()
                            .padding(.trailing)
                            .frame(width: 20, height: 20)
                    }
                    
                    Text("Enter your password.")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    SecureAuthTextField(placeholder: "Password", text: $password)
                }
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                VStack {
                    Button(action: {
                        self.viewModel.login(email: email, password: password)
                    }, label: {
                        Capsule()
                            .frame(width: 360, height: 40, alignment: .center)
                            .foregroundColor(Color(red: 29/255, green: 161/255, blue: 242/255))
                            .overlay(Text("Log in")
                                .foregroundColor(.white))
                    })
                    .padding(.bottom, 4)
                    
                    Text("Forget password?")
                        .foregroundColor(.blue)
                        .padding(.bottom)
                }
            }
        }
    }
}

#Preview {
    LogInView()
}

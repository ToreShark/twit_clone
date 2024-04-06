//
//  RegisterView.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 02.04.2024.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @Environment(\.presentationMode) var presentaionMode
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action: {
                        presentaionMode.wrappedValue.dismiss()
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
            Text("Creaete your account")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 35)
            
            VStack(alignment: .leading, spacing: nil, content: {
                CustomAuthText(placeholder: "Name", text: $name)
                CustomAuthText(placeholder: "Phone Number or email", text: $email)
                SecureAuthTextField(placeholder: "Password", text: $password)
            })
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            VStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                
                HStack {
                    Spacer()
                    Button(action: {
                        print("Attempting to register with name: \(name), email: \(email), and password: \(password)")
                        self.viewModel.register(name: name, username: name, email: email, password: password)
                    }) {
                        Capsule()
                            .frame(width: 60, height: 30, alignment: .center)
                            .foregroundColor(Color(red: 29/255, green: 161/255, blue: 242/255))
                            .overlay(Text("Next")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold))
                    }
                }
                .padding(.trailing, 24)
            }

        }
    }
}

#Preview {
    RegisterView()
}

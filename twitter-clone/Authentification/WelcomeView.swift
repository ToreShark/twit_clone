//
//  WelcomeView.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 02.04.2024.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var viwModel: AuthViewModel
    var body: some View {
        NavigationView {
            content
        }
        .navigationBarHidden(true)
        .navigationBarTitle("")
    }

    private var content: some View {
        VStack {
            header
            Spacer()
            mainText
            Spacer()
            authButtons
            Spacer()
            signUpInfo
        }
    }

    private var header: some View {
        HStack {
            Spacer()
            Image("Twitter")
                .resizable()
                .scaledToFill()
                .padding(.trailing)
                .frame(width: 20, height: 20)
            Spacer()
        }
    }

    private var mainText: some View {
        Text("Казахи сила и татары нас боятся, что такое почему")
            .font(.system(size: 30, weight: .heavy, design: .default))
            .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .center)
    }

    private var authButtons: some View {
        VStack {
            googleSignInButton
            appleSignInButton
            orText
            createAccountButton
        }
        .padding()
    }

    private var googleSignInButton: some View {
        Button(action: { print("Sign in with Google") }) {
            HStack {
                Image("google")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                Text("Continue with Google")
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding()
            }
            .overlay(RoundedRectangle(cornerRadius: 36)
                .stroke(Color.black, lineWidth: 1)
                .opacity(0.3)
                .frame(width: 320, height: 60, alignment: .center))
        }
    }

    private var appleSignInButton: some View {
        Button(action: { print("Sign in with Apple") }) {
            HStack {
                Image("apple")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                Text("Continue with Apple")
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding()
            }
            .overlay(RoundedRectangle(cornerRadius: 36)
                .stroke(Color.black, lineWidth: 1)
                .opacity(0.3)
                .frame(width: 320, height: 60, alignment: .center))
        }
    }

    private var orText: some View {
        HStack {
            Rectangle()
                .foregroundColor(.gray)
                .opacity(0.3)
                .frame(width: UIScreen.main.bounds.width * 0.3, height: 1)
            
            Text("OR")
                .foregroundColor(.gray)
            
            Rectangle()
                .foregroundColor(.gray)
                .opacity(0.3)
                .frame(width: UIScreen.main.bounds.width * 0.3, height: 1)
        }
    }

    private var createAccountButton: some View {
        NavigationLink(destination: RegisterView().navigationBarHidden(true)) {
            RoundedRectangle(cornerRadius: 36)
                .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                .frame(width: 320, height: 60, alignment: .center)
                .overlay(Text("Create account")
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding())
        }
    }

    private var signUpInfo: some View {
        VStack(alignment: .leading) {
            Text("By signing up, you agree to our Terms, Privacy policy, Cookie Use")
                .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
            HStack(spacing: 2) {
                Text("Already have an account? ")
                NavigationLink(destination: LogInView().navigationBarHidden(true)) {
                    Text("Log in").foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                }
            }
        }
        .padding(.bottom)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

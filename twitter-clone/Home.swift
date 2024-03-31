//
//  Home.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 30.03.2024.
//

import Foundation
import SwiftUI

struct Home: View {
    @State var selectedIndex = 0
    @State var showCreateTweet = false
    @State var text = ""
    var body: some View {
        VStack {
            ZStack{
                
                TabView {
                    Feed()
                        .onTapGesture {
                            self.selectedIndex = 0
                        }
                        .navigationBarHidden(true)
                        .tabItem {
                            if (selectedIndex == 0) {
                                Image("Home")
                                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color("bg"))
                            }
                            else {
                                Image("Home")
                            }
                        }
                        .tag(0)
                    SearchView()
                        .onTapGesture {
                            self.selectedIndex = 1
                        }
                        .navigationBarHidden(true)
                        .tabItem {
                            if (selectedIndex != 1) {
                                Image("Search")
                                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color("bg"))
                            }
                            else {
                                Image("Search")
                            }
                        }
                        .tag(1)
                    NotificationsView()
                        .onTapGesture {
                            self.selectedIndex = 2
                        }
                        .navigationBarHidden(true)
                        .tabItem {
                            if (selectedIndex != 2) {
                                Image("Notifications")
                                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color("bg"))
                            }
                            else {
                                Image("Notifications")
                            }
                        }
                        .tag(2)
                    MessagesView()
                        .onTapGesture {
                            self.selectedIndex = 3
                        }
                        .navigationBarHidden(true)
                        .tabItem {
                            if (selectedIndex != 3) {
                                Image("Messages")
                                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color("bg"))
                            }
                            else {
                                Image("Messages")
                            }
                        }
                        .tag(3)
                }
                VStack {
                   Spacer()
                    HStack {
                        Spacer ()
                        Button(action: {
                            self.showCreateTweet.toggle()
                        }, label: {
                            Image("tweet").renderingMode(
                                .template)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding()
                            .background(Color("bg"))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                        })
                    }
                    .padding()
                }
                .padding(.bottom, 65)
            }
            .sheet(isPresented: $showCreateTweet, content: {
                CreateTwitView(text: text)
            }
            )
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

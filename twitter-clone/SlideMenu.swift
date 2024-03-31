//
//  SlideMenu.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 31.03.2024.
//

import SwiftUI

struct SlideMenu: View {
    @State var show = false
    var menuButtons = ["Profile", "Lists", "Topics", "Bookmarks", "Moments"]
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var width = UIScreen.main.bounds.width

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Image("logo")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    HStack(alignment: .top, spacing: 12) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Cem")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Text("@cem_salta")
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 20) {
                                FollowView(count: 8, title: "Подписки")
                                FollowView(count: 16, title: "Подписчики")
                            }
                            .padding(.top, 10)
                            
                            Divider()
                                .padding(.top, 10)
                        }
                        Spacer(minLength: 0)
                        Button(action: {
                            withAnimation {
                                self.show.toggle()
                            }
                        }) {
                            Image(systemName: show ? "chevron.down" : "chevron.up")
                                .foregroundColor(Color("bg"))
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        ForEach(menuButtons, id: \.self) { item in
                            MenuButton(title: item)
                        }
                        
                        Divider()
                            .padding(.top)
                        Button(action: {
                            
                        }, label: {
                            MenuButton(title: "Twitter Ads")
                        })
                        
                        Divider()
                        
                        Button(action: {
                            
                        }, label: {
                            MenuButton(title: "Настройки и конфиденциальность")
                        })
                        .padding(.top, 20)
                        
                        Button(action: {
                            
                        }, label: {
                            MenuButton(title: "Справка центр")
                        })
                        
                        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                        
                        Divider()
                            .padding(.bottom)
                        
                        HStack {
                            Button(action: {
                                
                            }, label: {
                                Image("help")
                                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                    .resizable()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(Color("bg"))
                            })
                            
                            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                            
                            Image("barcode")
                                .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                .resizable()
                                .frame(width: 26, height: 26)
                                .foregroundColor(Color("bg"))
                        }
                    }
                    .opacity(show ? 1 : 0)
                    .frame(height: show ? nil : 0)
                    
                    VStack(alignment: .leading, content: {
                        Button(action: {
                            
                        }, label: {
                            Text("Создание нового аккаунта")
                                .foregroundColor(Color("bg"))
                        })
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Добавить новый аккаунт")
                                .foregroundColor(Color("bg"))
                        })
                        
                        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    })
                    .opacity(!show ? 1 : 0)
                    .frame(height: !show ? nil : 0)
                }
                .padding(.horizontal, 20)
                .padding(.top, edges?.top ?? 15)
                .padding(.bottom, edges?.bottom == 0 ? 15 : edges?.bottom)
                .frame(width: width - 90)
                .background(Color.white)
                .ignoresSafeArea(.all, edges: .vertical)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct SlideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenu()
    }
}

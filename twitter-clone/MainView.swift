//
//  MainView.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 31.03.2024.
//

import SwiftUI

struct MainView: View {
    @State var width = UIScreen.main.bounds.width - 90
    @State var x = -UIScreen.main.bounds.width + 90
    var body: some View {
        NavigationView{
            VStack {
                ZStack(alignment: /*@START_MENU_TOKEN@*/Alignment(horizontal: .center, vertical: .center)/*@END_MENU_TOKEN@*/, content: {
                    VStack{
                        TopBar(x: $x)
                        Home()
                    }
                    SlideMenu()
                        .shadow(color: Color.black.opacity(x != 0 ? 0.1 : 0), radius: 5, x:5, y:5)
                        .offset(x: x)
                        .background(Color.black.opacity(x == 0 ? 0.5 : 0))
                        .ignoresSafeArea(.all, edges: .vertical)
                        .onTapGesture {
                            withAnimation{
                                x = -width
                            }
                        }
                })
                .gesture(DragGesture().onChanged({(value) in
                    withAnimation{
                        
                        if value.translation.width > 0 {
                            if x < 0 {
                                x = -width + value.translation.width
                            }
                        }
                        else {
                            if x != -width {
                                x = value.translation.width
                            }
                        }
                        
                    }
                }).onEnded({(value) in
                    withAnimation{
                        if x > -width / 2 {
                            x = 0
                        }
                        else {
                            x = -width
                        }
                    }
                }))
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
        }
    }
}

#Preview {
    MainView()
}

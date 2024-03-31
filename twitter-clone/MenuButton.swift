//
//  MenuButton.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 31.03.2024.
//

import SwiftUI

struct MenuButton: View {
    var  title: String
    var body: some View {
        HStack (spacing: 15, content: {
            Image(title)
                .resizable()
                .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
            
            Text(title)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        })
        .padding(.vertical, 12)
    }
}

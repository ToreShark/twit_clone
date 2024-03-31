//
//  NotificationCell.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 31.03.2024.
//

import SwiftUI

struct NotificationCell: View {
    @State var width = UIScreen.main.bounds.width
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: width, height: 1, alignment: .center)
                .foregroundColor(.gray)
                .opacity(0.3)
            
            HStack(alignment: .top) {
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundColor(.blue)
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                VStack(alignment: .leading, spacing: 5, content: {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width:36, height: 36)
                        .cornerRadius(18)
                    
                    Text("Sem ")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                    
                    Text("folowed you")
                        .foregroundColor(.black)
                })
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            .padding(.leading, 30)
        }
    }
}

#Preview {
    NotificationCell()
}

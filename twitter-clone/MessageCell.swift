//
//  MessageCell.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 31.03.2024.
//

import SwiftUI

struct MessageCell: View {
    @State var width = UIScreen.main.bounds.width
    var body: some View {
        VStack(alignment: .leading, spacing: nil, content: {
            Rectangle()
                .frame(width: width, height: 1, alignment: .center)
                .foregroundColor(Color.gray)
                .opacity(0.3)
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                    .padding(.leading)
                VStack(alignment: .leading, spacing: 0, content: {
                    HStack {
                        Text("Cem ")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.primary)
                        Text("@cem_salta")
                            .foregroundColor(.gray)
                        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                        Text("6/20/21")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                    Text("Казахи очень сильная нация!!! Удар татаров на Казахстан не пройдет!!!")
                        .foregroundColor(.gray)
                       
                    Spacer()
                })
            }
            .padding(.top, 2)
        }).frame(width: width, height: 84)
    }
}

#Preview {
    MessageCell()
}

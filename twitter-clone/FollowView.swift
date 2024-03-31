//
//  FollowView.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 31.03.2024.
//

import SwiftUI

struct FollowView: View {
    var count: Int
    var title: String
    var body: some View {
        HStack{
            Text("\(count)")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black)
            Text(title)
                .foregroundColor(.gray)
        }
    }
}

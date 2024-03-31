//
//  SearchView.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 30.03.2024.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var isEditing = false
    var body: some View {
        VStack {
            
            SearchBar(text: $text, isEditing: $isEditing)
                .padding(.horizontal)
            if !isEditing {
                List(0..<9) { i in
                    SearchCell(tag: "Hello", tweets: "\(i) ")
                }
            }
            else {
                List(0..<9) { _ in
                    SearchUserCell()
                }
            }
            
        }
    }
}

#Preview {
    SearchView()
}

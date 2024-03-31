//
//  SearchBar.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 31.03.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            TextField("Поиск", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .overlay(
                
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
            Button(action: {
                withAnimation {
                    isEditing = false
                    text = ""
                    UIApplication.shared.endEditing()
                }
            }, label: {
                Text("Отмена")
                    .foregroundColor(.black)
                    .padding(.trailing, 8)
                    .transition(.move(edge: .trailing))
            })
        }
        .onTapGesture {
            isEditing = true
        }
    }
}



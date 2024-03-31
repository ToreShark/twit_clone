//
//  MessagesView.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 30.03.2024.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        VStack{
            ScrollView {
                VStack {
                    ForEach(0..<10) { _ in
                        MessageCell()
                    }
                }
            }
        }
    }
}

#Preview {
    MessagesView()
}

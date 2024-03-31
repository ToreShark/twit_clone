//
//  Feed.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 30.03.2024.
//

import SwiftUI

struct Feed: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false,
                   content: {
            VStack(spacing: 18) {
                
                TweetCellView(tweet: "Казахи очень сильная нация! Удар 4 татар, второй удар 5 татар",
                              tweetImage: "post")
                Divider()
                
                ForEach(1...20, id: \.self) { _ in
                    TweetCellView(tweet: sampleText)
                    Divider()
                }
            }
            .padding(.top)
            .padding(.horizontal)
            .zIndex(0)
        })
    }
}

#Preview {
    Feed()
}

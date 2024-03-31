//
//  TweetCellView.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 30.03.2024.
//

import SwiftUI

struct TweetCellView: View {
    
    var tweet: String
    var tweetImage: String?
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 10, content: {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 10,
                       content: {
                        (
                            Text("Torekhan ")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.primary)
                            +
                            Text("@torekhan")
                                .foregroundColor(.gray)
                        )
                    Text(tweet)
                        .frame(maxHeight: 100, alignment: .top)
                    
                    if let image = tweetImage {
                        GeometryReader { proxy in
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.frame(in: .global).width, height: 250)
                                .cornerRadius(15)
                        }
                        .frame(height: 250)
                    }
                        
                })
            })
            // cell bottom
            HStack(spacing: 50, content: {
                Button(action: {
                    
                }, label: {
                    Image("Comments").resizable().frame(width: 16, height: 16)
                }).foregroundColor(.gray)
                
                Button(action: {
                    
                }, label: {
                    Image("Retweet").resizable().frame(width: 18, height: 14)
                }).foregroundColor(.gray)
                
                Button(action: {
                    
                }, label: {
                    Image("love").resizable().frame(width: 18, height: 15)
                }).foregroundColor(.gray)
                
                Button(action: {
                    
                }, label: {
                    Image("upload").resizable()
                        .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                        .frame(width: 18, height: 15)
                }).foregroundColor(.gray)
            })
            .padding(.top, 4)
        }
    }
}

struct TweetCellView_Previews: PreviewProvider {
    static var previews: some View {
        TweetCellView(tweet: sampleText)
    }
}
// create lorem 30 symbols
var sampleText: String {
    var result = ""
    for _ in 0..<30 {
        result += "lorem"
    }
    return result
}


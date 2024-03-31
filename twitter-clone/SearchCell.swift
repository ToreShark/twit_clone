//
//  SearchCell.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 31.03.2024.
//

import SwiftUI

struct SearchCell: View {
    var tag = ""
    var tweets = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Text("hello").fontWeight(.heavy)
            Text(tweets + "Tweets").fontWeight(.light)
        })
    }
}

#Preview {
    SearchCell()
}

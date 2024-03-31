//
//  CreateTwitView.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 30.03.2024.
//

import SwiftUI

struct CreateTwitView: View {
    
    @State var text: String = ""
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    
                }, label: {
                    Text("Cancel" )
                })
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("Tweet").padding()
                })
                .background(Color("bg"))
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            
            MultiLineTextField(text: $text)
        }
        .padding()
    }
}

#Preview {
    CreateTwitView()
}

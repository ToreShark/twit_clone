//
//  BlurView.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 31.03.2024.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

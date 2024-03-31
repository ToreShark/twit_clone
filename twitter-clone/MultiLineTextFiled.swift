//
//  MultiLineTextFiled.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 30.03.2024.
//

import Foundation
import SwiftUI

struct MultiLineTextField: UIViewRepresentable {
    @Binding var text: String
    let placeholder = "Type Something..."

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.delegate = context.coordinator
        textView.font = .systemFont(ofSize: 20)
        textView.textColor = .gray
        textView.text = placeholder

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text.isEmpty || uiView.text == placeholder {
            uiView.text = placeholder
            uiView.textColor = .gray
        } else {
            uiView.text = text
            uiView.textColor = .black
        }
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultiLineTextField

        init(_ parent: MultiLineTextField) {
            self.parent = parent
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeholder {
                textView.text = ""
                textView.textColor = .black
            }
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text == parent.placeholder ? "" : textView.text
        }
    }
}

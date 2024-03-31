//
//  Extensions.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 31.03.2024.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

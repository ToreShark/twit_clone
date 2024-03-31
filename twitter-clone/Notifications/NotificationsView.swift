//
//  NotificationsView.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 30.03.2024.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<9) { _ in
                    NotificationCell()
                }
            }
        }
    }
}

#Preview {
    NotificationsView()
}

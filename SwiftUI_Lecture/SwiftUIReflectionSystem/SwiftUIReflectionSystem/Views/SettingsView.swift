//
//  SettingsView.swift
//  SwiftUIReflectionSystem
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Button("알림 권한 요청") {
                NotificationManager.shared.requestPermission()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}

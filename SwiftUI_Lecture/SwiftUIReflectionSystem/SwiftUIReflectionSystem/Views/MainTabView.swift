//
//  TabView.swift
//  SwiftUIReflectionSystem
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

struct MainTabView: View {
    init() {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground() // 불투명한 배경 설정
            appearance.backgroundColor = UIColor.white // 배경색을 흰색으로 설정 (원하는 색상으로 변경 가능)
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance // iOS 15 이상에서 적용
        }
    
    var body: some View {
        TabView {
            NavigationStack {
                ContentView()
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("회고")
            }
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("설정")
            }
        }
    }
}

#Preview {
    MainTabView()
}

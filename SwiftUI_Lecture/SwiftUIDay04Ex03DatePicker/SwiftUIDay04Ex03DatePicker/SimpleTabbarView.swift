//
//  SimpleTabbarView.swift
//  SwiftUIDay04Ex03DatePicker
//
//  Created by 도민준 on 2/13/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "house.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            Text("Welcome to Home!")
                .font(.title)
                .padding()
        }
    }
}

struct SettingsView: View {
    var body: some View {
        VStack {
            Image(systemName: "gearshape.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
            Text("Settings Screen")
                .font(.title)
                .padding()
        }
    }
}

struct ProfileView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.orange)
            Text("Profile Screen")
                .font(.title)
                .padding()
        }
    }
}

struct SimpleTabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
        }
        .accentColor(.blue) // 탭바 아이템의 색상
    }
}

#Preview {
    SimpleTabBarView()
}

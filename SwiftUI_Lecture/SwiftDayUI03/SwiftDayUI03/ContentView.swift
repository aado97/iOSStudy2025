//
//  ContentView.swift
//  SwiftDayUI03
//
//  Created by 도민준 on 2/12/25.
//

import SwiftUI

class CntClass {
    var count = 0
    
    func increment() {
        count += 1
    }
}

struct HomeView: View {
    // 상태 변수 재 랜더링 한다.
    //var count = 0
    // 레퍼런스로 선언하고 레퍼런스의 필드를 변경한다.
    var countRef: CntClass = CntClass()
    
    var body: some View {
        VStack {
            Image(systemName: "house.fill")
                .resizable()
                .frame(width: 200, height: 200)
            Text("Welcome to Home!")
                .padding(20)
            Button("증가") {
                print("증가 버튼 눌렀다.", countRef.count)
                countRef.count += 1
            }
        }
    }
}

struct Settings: View {
    var body: some View {
        VStack {
            Image(systemName: "gear")
                .resizable()
                .frame(width: 200, height: 200)
            Text("Welcome to Settings!")
        }
    }
}

struct Profile: View {
    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 200, height: 200)
            Text("Profile Page!")
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Label("Home", systemImage: "house")
            }
            Settings().tabItem {
                Label("Settings", systemImage: "gear")
            }
            Profile().tabItem {
                Label("Profile", systemImage: "person.circle")
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  SwiftUIReflectionSystem
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ReflectionViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.reflections) { reflection in
                NavigationLink(destination: ReflectionDetailView(reflection: reflection)) {
                    VStack(alignment: .leading) {
                        Text(DateUtil.shared.formattedDate(reflection.date))
                            .font(.headline)
                        Text(reflection.content)
                            .lineLimit(1)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("회고 리스트")
            .toolbar {
                NavigationLink {
                    ReflectionView()
                        .environmentObject(viewModel)
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
        .onAppear {
            viewModel.loadReflection()
        }
    }
}

#Preview {
    ContentView()
}

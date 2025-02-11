//
//  HomeView.swift
//  SwiftUIDay02ShopStep01
//
//  Created by 도민준 on 2/11/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ProductListView()
                .navigationTitle("과일 상회")
        }
    }
}

#Preview {
    HomeView()
}

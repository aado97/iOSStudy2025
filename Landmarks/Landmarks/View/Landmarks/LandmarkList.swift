//
//  LandmarkList.swift
//  Landmarks
//
//  Created by 도민준 on 1/30/25.
//

import SwiftUI

struct LandmarkList: View {
    @Environment(ModelData.self) var modelData
    @State private var showFovoritesOnly = false
    
    var filteredLandmakrs: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFovoritesOnly || landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                Toggle(isOn: $showFovoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(filteredLandmakrs) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .animation(.default, value: filteredLandmakrs)
            .navigationTitle("Landmarks")
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    LandmarkList()
        .environment(ModelData())
}

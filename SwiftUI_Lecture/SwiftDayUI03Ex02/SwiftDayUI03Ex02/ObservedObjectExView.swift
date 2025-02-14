//
//  ObservedObjectExView.swift
//  SwiftDayUI03Ex02
//
//  Created by 도민준 on 2/12/25.
//

import SwiftUI

class CntClass: ObservableObject {
    @Published var count: Int = 0
}

struct ObservedObjectExView: View {
    @ObservedObject var cntObj: CntClass = CntClass()
    
    var body: some View {
        VStack {
            Text("ObservedObjectExView")
                .font(.title)
                .padding()
            Text("Count: \(cntObj.count)")
            Button("증가") {
                print("증가하기 버튼 탭")
                cntObj.count += 1
                print(cntObj.count)
            }
            .padding()
        }
    }
}

#Preview {
    ObservedObjectExView()
}

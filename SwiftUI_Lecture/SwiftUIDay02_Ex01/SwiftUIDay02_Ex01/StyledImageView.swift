//
//  StyledImageView.swift
//  SwiftUIDay02_Ex01
//
//  Created by 도민준 on 2/11/25.
//

import SwiftUI

struct StyledImageView: View {
    var body: some View {
        Image("1_")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .clipShape(Circle())
            .padding(10)
    }
}

// 이전 버전 호환 가능 프로바이더
struct StyledImageView_Previews: PreviewProvider {
    static var previews: some View {
        StyledImageView()
    }
}

//#Preview {
//    StyledImageView()
//}

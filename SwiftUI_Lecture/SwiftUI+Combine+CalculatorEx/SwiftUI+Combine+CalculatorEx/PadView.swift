//
//  PadView.swift
//  SwiftUI+Combine+CalculatorEx
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

struct PadView: View {
    // 숫자 버튼 간 여백
    private let spacing = AppConstant.UI.padSpacing
    
    var body: some View {
        VStack(spacing: self.spacing) {
            HStack(spacing: self.spacing) {
                Button("AC", action: {})
                    .buttonStyle(NumberPadStyle(color: .gray))
                Button("+/-", action: {})
                    .buttonStyle(NumberPadStyle(color: .gray))
                Button("%", action: {})
                    .buttonStyle(NumberPadStyle(color: .gray))
                Button("÷", action: {})
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
            
            HStack(spacing: self.spacing) {
                Button("7", action: {})
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("8", action: {})
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("9", action: {})
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("✕", action: {})
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
            
            HStack(spacing: self.spacing) {
                Button("4", action: {})
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("5", action: {})
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("6", action: {})
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("-", action: {})
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
            
            HStack(spacing: self.spacing) {
                Button("1", action: {})
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("2", action: {})
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("3", action: {})
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("+", action: {})
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
            
            HStack(spacing: self.spacing) {
                Button("0", action: {})
                    .buttonStyle(WidePadStyle(color: .brown))
                Button(".", action: {})
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("=", action: {})
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
        }
    }
}

#Preview {
    PadView()
}

/*
 struct PadView_Previews: PreviewProvider {
     static var previews: some View {
         PadView()
     }
 }
 */

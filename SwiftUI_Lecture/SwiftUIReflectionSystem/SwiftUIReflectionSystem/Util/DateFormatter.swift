//
//  DateFormatter.swift
//  SwiftUIReflectionSystem
//
//  Created by 도민준 on 2/14/25.
//

import Foundation

class DateUtil {
    static let shared = DateUtil()
    
    private let formatter: DateFormatter
    
    private init() {
        formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
    }
    
    func formattedDate(_ date: Date) -> String {
        return formatter.string(from: date)
    }
}

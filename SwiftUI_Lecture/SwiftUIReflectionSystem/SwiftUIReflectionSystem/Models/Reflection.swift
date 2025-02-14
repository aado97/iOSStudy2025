//
//  Reflection.swift
//  SwiftUIReflectionSystem
//
//  Created by 도민준 on 2/14/25.
//

import Foundation

struct Reflection: Codable, Identifiable {
    var id: UUID = UUID()
    var date: Date
    var content: String
}

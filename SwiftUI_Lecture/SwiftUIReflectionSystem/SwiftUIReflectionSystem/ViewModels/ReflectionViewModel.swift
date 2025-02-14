//
//  ReflectionViewModel.swift
//  SwiftUIReflectionSystem
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

class ReflectionViewModel: ObservableObject {
  @Published var reflections: [Reflection] = []
  private let userDefaultsKey = "reflections"
  
  func saveReflection() {
    if let encodedData = try? JSONEncoder().encode(reflections) {
      UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
    }
  }
  
  func loadReflection() {
    if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
       let loadedReflections = try? JSONDecoder().decode([Reflection].self, from: savedData) {
      reflections = loadedReflections
    }
  }
}

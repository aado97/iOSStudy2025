//
//  main.swift
//  CombineEx
//
//  Created by 도민준 on 2/15/25.
//

import Combine

let publisher = [1, 2, 3, 4, 5].publisher

let subscription = publisher
    .filter { $0 % 2 == 0 }
    .sink { value in
        print("Received value: \(value)")
    }

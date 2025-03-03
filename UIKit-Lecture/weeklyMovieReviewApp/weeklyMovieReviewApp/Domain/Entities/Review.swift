//
//  Review.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/3/25.
//

import Foundation

struct Review: Codable {
    let id: UUID
    let movieID: String
    let content: String
    let date: Date
}

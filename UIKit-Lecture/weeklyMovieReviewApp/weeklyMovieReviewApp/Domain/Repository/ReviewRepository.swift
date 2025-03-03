//
//  ReviewRepository.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/4/25.
//


import Foundation

protocol ReviewRepository {
    func loadReviews(for movieID: String) -> [Review]
    func saveReview(_ review: Review)
}
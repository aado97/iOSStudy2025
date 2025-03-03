//
//  ReviewUseCase.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/3/25.
//


import Foundation

class ReviewUseCase {
    private let repository: ReviewRepository
    
    init(repository: ReviewRepository) {
        self.repository = repository
    }
    
    func getReviews(for movieID: String) -> [Review] {
        return repository.loadReviews(for: movieID)
    }
    
    func addReview(for movieID: String, content: String) {
        let review = Review(id: UUID(), movieID: movieID, content: content, date: Date())
        repository.saveReview(review)
    }
}

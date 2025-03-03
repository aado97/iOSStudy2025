//
//  ReviewRepositoryImpl.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/3/25.
//


import Foundation

class ReviewRepositoryImpl: ReviewRepository {
    private let fileName = "reviews.json"
    
    private var fileURL: URL? {
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent(fileName)
    }
    
    func loadReviews(for movieID: String) -> [Review] {
        guard let url = fileURL else { return [] }
        do {
            let data = try Data(contentsOf: url)
            let reviews = try JSONDecoder().decode([Review].self, from: data)
            return reviews.filter { $0.movieID == movieID }
        } catch {
            print("리뷰 불러오기 실패: \(error)")
            return []
        }
    }
    
    func saveReview(_ review: Review) {
        var allReviews = loadAllReviews()
        allReviews.append(review)
        saveAllReviews(allReviews)
    }
    
    private func loadAllReviews() -> [Review] {
        guard let url = fileURL else { return [] }
        do {
            let data = try Data(contentsOf: url)
            let reviews = try JSONDecoder().decode([Review].self, from: data)
            return reviews
        } catch {
            return []
        }
    }
    
    private func saveAllReviews(_ reviews: [Review]) {
        guard let url = fileURL else { return }
        do {
            let data = try JSONEncoder().encode(reviews)
            try data.write(to: url)
        } catch {
            print("리뷰 저장 실패: \(error)")
        }
    }
}

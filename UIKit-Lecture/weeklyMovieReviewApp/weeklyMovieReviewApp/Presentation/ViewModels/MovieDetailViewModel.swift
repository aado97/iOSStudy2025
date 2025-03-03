//
//  MovieDetailViewModel.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/3/25.
//


import Foundation

class MovieDetailViewModel {
    private let reviewUseCase: ReviewUseCase
    let movie: Movie
    var reviews: [Review] = [] {
        didSet { self.reloadTableView?() }
    }
    
    var reloadTableView: (() -> Void)?
    
    init(movie: Movie, reviewUseCase: ReviewUseCase) {
        self.movie = movie
        self.reviewUseCase = reviewUseCase
    }
    
    func loadReviews() {
        reviews = reviewUseCase.getReviews(for: movie.id)
    }
    
    func addReview(content: String) {
        reviewUseCase.addReview(for: movie.id, content: content)
        loadReviews()
    }
    
    var isFavorite: Bool {
        // FavoritesManager 메서드가 Movie 객체를 받도록 정의되어 있음
        return FavoritesManager.shared.isFavorite(movie)
    }
    
    func toggleFavorite() {
        if isFavorite {
            FavoritesManager.shared.removeFavorite(movie)
        } else {
            FavoritesManager.shared.addFavorite(movie)
        }
    }
}

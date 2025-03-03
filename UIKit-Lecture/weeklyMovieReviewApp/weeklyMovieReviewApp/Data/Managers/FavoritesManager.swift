//
//  FavoritesManager.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/3/25.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private init() {}
    
    private var favoriteMovies: [Movie] = []
    
    // 즐겨찾기 추가
    func addFavorite(_ movie: Movie) {
        if !favoriteMovies.contains(where: { $0.id == movie.id }) {
            favoriteMovies.append(movie)
        }
    }
    
    // 즐겨찾기 제거
    func removeFavorite(_ movie: Movie) {
        favoriteMovies.removeAll { $0.id == movie.id }
    }
    
    // 즐겨찾기 여부 확인
    func isFavorite(_ movie: Movie) -> Bool {
        return favoriteMovies.contains(where: { $0.id == movie.id })
    }
    
    // 즐겨찾기 목록 반환
    func getFavorites() -> [Movie] {
        return favoriteMovies
    }
}
